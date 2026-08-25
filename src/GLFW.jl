module GLFW

using GLFW_jll

struct ThreadAssertionError
	target_thread::Int
	current_thread::Int
end

"""
	ThreadAssertionError(target_thread[, current_thread = Threads.threadid()])

The currently used thread is different from the `target_thread` that must be used.
"""
ThreadAssertionError(target) = ThreadAssertionError(target, Threads.threadid())

function Base.showerror(io::IO, e::ThreadAssertionError)
	print(io, "ThreadAssertionError: Code must run on thread $(e.target_thread) but ran on thread $(e.current_thread).")
end

const ENABLE_THREAD_ASSERTIONS = Ref(get(ENV, "GLFW_ENABLE_THREAD_ASSERTIONS", "true") == "true")

# The GLFW docs notes on most function that they should only be called from the main thread
function require_main_thread()
	if ENABLE_THREAD_ASSERTIONS[] && Threads.threadid() != 1
		throw(ThreadAssertionError(1))
	end
	return
end

macro require_main_thread(code)
	esc(quote
		require_main_thread()
		$code
	end)
end

function GetVersion()
	# any thread
	major, minor, rev = Ref{Cint}(), Ref{Cint}(), Ref{Cint}()
	ccall((:glfwGetVersion, libglfw), Cvoid, (Ref{Cint}, Ref{Cint}, Ref{Cint}), major, minor, rev)
	VersionNumber(major[], minor[], rev[])
end

include("callback.jl")
include("glfw3.jl")
include("vulkan.jl")
include("monitor_properties.jl")

# Platforms `__init__` tries, in order. A platform named by JULIA_GLFW_PLATFORM
# is used alone, so failing to initialize it is fatal. Otherwise ANY_PLATFORM
# catches a working platform the default misses (e.g. Wayland without X11), and
# PLATFORM_NULL initializes without a display but cannot create windows.
function InitCandidates()
	requested = RequestedPlatform()
	# ANY_PLATFORM asks GLFW to choose rather than naming a platform, so it
	# still gets the fallbacks below. GLFW never chooses PLATFORM_NULL itself.
	names_a_platform = !isnothing(requested) && requested !== ANY_PLATFORM
	names_a_platform && return Platform[requested]

	candidates = isnothing(requested) ? Platform[OS_DEFAULT_PLATFORM, ANY_PLATFORM] : Platform[ANY_PLATFORM]
	PlatformSupported(PLATFORM_NULL) && push!(candidates, PLATFORM_NULL)
	return unique!(candidates)
end

function __init__()
	# Save errors that occur during initialization
	errors = Vector{Exception}()
	SetErrorCallback(err -> push!(errors, err))

	candidates = InitCandidates()
	try
		for platform in candidates
			Init(platform = platform) && break
		end
	finally
		SetErrorCallback(throw)
	end

	is_initialized() || throw(errors)  # Throw fatal errors

	atexit(Terminate)
	for err in errors
		@warn err  # Warn about any non-fatal errors that may have occurred during initialization
	end
	if GetPlatform() === PLATFORM_NULL && candidates != [PLATFORM_NULL]
		@warn "GLFW found no usable windowing platform and fell back to its NULL platform: the " *
		      "package is usable, but windows cannot be created or shown. Detect this with " *
		      "`GLFW.GetPlatform() == GLFW.PLATFORM_NULL`. To make this fatal instead, set the " *
		      "JULIA_GLFW_PLATFORM environment variable to the platform you require " *
		      "(e.g. \"x11\" or \"wayland\")."
	end
	return
end

end
