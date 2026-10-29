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

# Initializing GLFW is restricted to the main thread, even for functions that
# may otherwise be called from any thread once initialization has completed.
function ensure_initialized()
	is_initialized() || Init() || throw(GLFWError(NOT_INITIALIZED, "GLFW initialization failed"))
	return
end

macro require_initialized(code)
	esc(quote
		require_main_thread()
		ensure_initialized()
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

# Platforms `Init` tries, in order. An explicitly named platform
# is used alone, so failing to initialize it does not fall back. Otherwise ANY_PLATFORM
# catches a working platform the default misses (e.g. Wayland without X11), and
# PLATFORM_NULL initializes without a display and has no visible windows.
function InitCandidates(requested = RequestedPlatform())
	# ANY_PLATFORM asks GLFW to choose rather than naming a platform, so it
	# still gets the fallbacks below. GLFW never chooses PLATFORM_NULL itself.
	names_a_platform = !isnothing(requested) && requested !== ANY_PLATFORM
	names_a_platform && return Platform[requested]

	candidates = isnothing(requested) ? Platform[OS_DEFAULT_PLATFORM, ANY_PLATFORM] : Platform[ANY_PLATFORM]
	PlatformSupported(PLATFORM_NULL) && push!(candidates, PLATFORM_NULL)
	return unique!(candidates)
end

function __init__()
	SetErrorCallback(throw)
	atexit(Terminate)
	return
end

end
