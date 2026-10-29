@testset "lazy initialization" begin
	if GLFW.PlatformSupported(GLFW.PLATFORM_NULL)
		withenv("JULIA_GLFW_PLATFORM" => "null") do
			# These functions must remain usable before initialization.
			GLFW.Terminate()
			GLFW.InitHint(GLFW.COCOA_MENUBAR, false)
			callback = err -> nothing
			old = GLFW.SetErrorCallback(callback)
			@test GLFW.SetErrorCallback(old) === callback
			@test !GLFW.is_initialized()
			@test (@test_logs GLFW.Init())
			GLFW.Terminate()
			if Threads.nthreads() > 1
				# No C initialization may happen on a secondary thread. Once
				# initialized, any-thread queries must still work there.
				Threads.@threads for i in 1:Threads.nthreads()
					if Threads.threadid() != 1
						@test_throws GLFW.ThreadAssertionError GLFW.GetPlatform()
					end
				end
				@test !GLFW.is_initialized()
				@test GLFW.Init()
				Threads.@threads for i in 1:Threads.nthreads()
					@test GLFW.GetPlatform() == GLFW.PLATFORM_NULL
				end
			end

			# Every independent first-use entry point must initialize. In
			# particular, initialize before hints so glfwInit cannot reset them.
			for first_use in (
				GLFW.GetPlatform, GLFW.GetMonitors, GLFW.GetPrimaryMonitor,
				GLFW.DefaultWindowHints, GLFW.PollEvents, GLFW.PostEmptyEvent,
				GLFW.GetCurrentContext, GLFW.VulkanSupported,
				() -> GLFW.WindowHint(GLFW.CLIENT_API, GLFW.NO_API),
				() -> GLFW.WindowHintString(GLFW.X11_CLASS_NAME, "test"),
				() -> GLFW.SetMonitorCallback(nothing),
				() -> GLFW.SetJoystickCallback(nothing),
			)
				GLFW.Terminate()
				first_use()
				@test GLFW.is_initialized()
				@test GLFW.GetPlatform() == GLFW.PLATFORM_NULL
			end

			GLFW.Terminate()
			GLFW.WindowHint(GLFW.CLIENT_API, GLFW.NO_API)
			GLFW.WindowHint(GLFW.VISIBLE, false)
			@test GLFW.Init(platform = GLFW.OS_DEFAULT_PLATFORM)
			@test GLFW.GetPlatform() == GLFW.PLATFORM_NULL
			window = GLFW.CreateWindow(32, 32, "headless")
			try
				@test GLFW.GetWindowAttrib(window, GLFW.CLIENT_API) == GLFW.NO_API
				@test GLFW.GetWindowAttrib(window, GLFW.VISIBLE) == 0
				GLFW.SetWindowShouldClose(window, true)
				@test GLFW.WindowShouldClose(window)
			finally
				GLFW.DestroyWindow(window)
			end

			# The direct CreateWindow entry point initializes too. Its default
			# OpenGL context may fail without OSMesa, but must never segfault if
			# the error callback is disabled.
			GLFW.Terminate()
			old = GLFW.SetErrorCallback(nothing)
			try
				window = try
					GLFW.CreateWindow(32, 32, "OpenGL")
				catch err
					@test err isa ErrorException
					nothing
				end
				@test GLFW.is_initialized()
				window === nothing || GLFW.DestroyWindow(window)
			finally
				GLFW.SetErrorCallback(old)
				GLFW.Terminate()
			end
		end
	end
end

@testset "initialization failure and callbacks" begin
	# A platform not compiled into this library fails on every machine, without
	# depending on whether a display server happens to be running.
	for platform in (GLFW.PLATFORM_WIN32, GLFW.PLATFORM_COCOA, GLFW.PLATFORM_X11, GLFW.PLATFORM_WAYLAND)
		GLFW.PlatformSupported(platform) && continue
		GLFW.Terminate()
		@test !(@test_logs (:warn,) match_mode = :any GLFW.Init(platform = platform))
		@test !GLFW.is_initialized()
		errors = GLFW.GLFWError[]
		callback = err -> push!(errors, err)
		old = GLFW.SetErrorCallback(callback)
		try
			@test !GLFW.Init(platform = platform)
			@test !isempty(errors)
			@test GLFW.SetErrorCallback(callback) === callback
		finally
			GLFW.SetErrorCallback(old)
		end
		# A failed explicit attempt must not prevent a later valid one.
		if GLFW.PlatformSupported(GLFW.PLATFORM_NULL)
			@test GLFW.Init(platform = GLFW.PLATFORM_NULL)
			@test_throws GLFW.GLFWError GLFW.WindowHint(0, 0)
		end
		GLFW.Terminate()
	end
end

# A real instance with no surface extensions deliberately exercises the VkResult
# failure path without passing an invalid Vulkan handle into the driver.
struct TestVkInstanceCreateInfo
    sType::Cuint
    pNext::Ptr{Cvoid}
    flags::Cuint
    pApplicationInfo::Ptr{Cvoid}
    enabledLayerCount::Cuint
    ppEnabledLayerNames::Ptr{Cstring}
    enabledExtensionCount::Cuint
    ppEnabledExtensionNames::Ptr{Cstring}
end

@testset "Vulkan without presentation" begin
    @test GLFW.VkResult === Cint
    @test_throws ArgumentError GLFW.CreateWindowSurface(C_NULL, GLFW.Window(C_NULL))
    if GLFW.PlatformSupported(GLFW.PLATFORM_NULL)
        withenv("JULIA_GLFW_PLATFORM" => "null") do
            GLFW.Terminate()
            if GLFW.VulkanSupported()
                GLFW.Terminate()
                extensions = GLFW.GetRequiredInstanceExtensions()
                count = Ref{Cuint}(42)
                ptr = GLFW.GetRequiredInstanceExtensions(count)
                @test count[] == length(extensions)
                if isempty(extensions)
                    @test ptr == C_NULL
                else
                    # Newer GLFW can expose VK_EXT_headless_surface on NULL
                    # when the Vulkan driver supports it. It is not required
                    # for compute, rasterization or ray tracing offscreen.
                    @test "VK_KHR_surface" in extensions
                    @test "VK_EXT_headless_surface" in extensions
                end
                create = GLFW.GetInstanceProcAddress(C_NULL, "vkCreateInstance")
                info = TestVkInstanceCreateInfo(1, C_NULL, 0, C_NULL, 0, C_NULL, 0, C_NULL)
                instance = Ref{GLFW.VkInstance}(C_NULL)
                result = ccall(create, GLFW.VkResult,
                    (Ref{TestVkInstanceCreateInfo}, Ptr{Cvoid}, Ref{GLFW.VkInstance}), info, C_NULL, instance)
                if result in (-3, -9) # VK_ERROR_INITIALIZATION_FAILED / VK_ERROR_INCOMPATIBLE_DRIVER
                    @info "Vulkan loader found, but no usable ICD could create an instance" result
                    @test_skip result == 0
                else
                    @test result == 0
                end
                if result == 0
                    destroy = GLFW.GetInstanceProcAddress(instance[], "vkDestroyInstance")
                    GLFW.WindowHint(GLFW.CLIENT_API, GLFW.NO_API)
                    window = GLFW.CreateWindow(32, 32, "Vulkan")
                    old = GLFW.SetErrorCallback(nothing)
                    try
                        err = try
                            GLFW.CreateWindowSurface(instance[], window)
                        catch err
                            err
                        end
                        @test err isa ErrorException
                        @test occursin("glfwCreateWindowSurface failed with VkResult -", sprint(showerror, err))
                    finally
                        GLFW.SetErrorCallback(old)
                        GLFW.DestroyWindow(window)
                        ccall(destroy, Cvoid, (GLFW.VkInstance, Ptr{Cvoid}), instance[], C_NULL)
                    end
                end
            end
            GLFW.Terminate()
        end
    end
end
