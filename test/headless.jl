@testset "automatic headless OpenGL" begin
	if GLFW.PlatformSupported(GLFW.PLATFORM_NULL)
		withenv("JULIA_GLFW_PLATFORM" => "null") do
			GLFW.Terminate()
			for query in (GLFW.GetMonitorPos, GLFW.GetMonitorPhysicalSize, GLFW.GetMonitorContentScale,
				GLFW.GetMonitorName, GLFW.GetVideoModes, GLFW.GetVideoMode, m -> GLFW.SetGamma(m, 1.0))
				@test_throws ArgumentError query(GLFW.Monitor(C_NULL))
			end
			window = try
				GLFW.CreateWindow(32, 32, "offscreen")
			catch err
				err isa GLFW.GLFWError || rethrow()
				@test err.code == GLFW.API_UNAVAILABLE
				@test occursin("EGL and OSMesa", err.description)
				nothing
			end
			if !isnothing(window)
				try
					api = GLFW.GetWindowAttrib(window, GLFW.CONTEXT_CREATION_API)
					@test api in (GLFW.EGL_CONTEXT_API, GLFW.OSMESA_CONTEXT_API)
					GLFW.MakeContextCurrent(window)
					clearcolor = GLFW.GetProcAddress("glClearColor")
					clear = GLFW.GetProcAddress("glClear")
					readpixels = GLFW.GetProcAddress("glReadPixels")
					ccall(clearcolor, Cvoid, (Cfloat, Cfloat, Cfloat, Cfloat), 0.25, 0.5, 0.75, 1)
					ccall(clear, Cvoid, (Cuint,), 0x4000)
					pixel = zeros(UInt8, 4)
					ccall(readpixels, Cvoid, (Cint, Cint, Cint, Cint, Cuint, Cuint, Ptr{UInt8}),
						0, 0, 1, 1, 0x1908, 0x1401, pixel)
					@test all(abs.(Int.(pixel) .- [64, 128, 191, 255]) .<= 1)
					@test_throws ErrorException GLFW.ShowWindow(window)
					shared = GLFW.CreateWindow(16, 16, "shared", GLFW.Monitor(C_NULL), window)
					try
						@test GLFW.GetWindowAttrib(shared, GLFW.CONTEXT_CREATION_API) == api
					finally
						GLFW.DestroyWindow(shared)
					end
					# Explicit choices and DefaultWindowHints must not be lost
					# while the automatic path temporarily sets the C hint.
					GLFW.WindowHint(GLFW.CONTEXT_CREATION_API, api)
					explicit = GLFW.CreateWindow(16, 16, "explicit")
					try
						@test GLFW.GetWindowAttrib(explicit, GLFW.CONTEXT_CREATION_API) == api
					finally
						GLFW.DestroyWindow(explicit)
					end
					GLFW.DefaultWindowHints()
					@test GLFW.CONTEXT_CREATION_API_HINT[] === nothing
					hidden = GLFW.Window(visible = false)
					try
						@test all(>(0), Tuple(GLFW.GetWindowSize(hidden)))
					finally
						GLFW.DestroyWindow(hidden)
					end
				finally
					GLFW.DestroyWindow(window)
				end
			end
			@test_throws GLFW.GLFWError GLFW.CreateWindow(0, 32, "invalid")
			@test_throws ErrorException GLFW.Window(visible = true, resolution = (32, 32))
			GLFW.DefaultWindowHints()
			GLFW.WindowHint(GLFW.CLIENT_API, GLFW.NO_API)
			window = GLFW.CreateWindow(16, 16, "no OpenGL dependency")
			try
				@test GLFW.GetWindowAttrib(window, GLFW.CLIENT_API) == GLFW.NO_API
			finally
				GLFW.DestroyWindow(window)
				GLFW.Terminate()
			end
		end
	end
end
