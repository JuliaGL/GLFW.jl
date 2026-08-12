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

function __init__()
	# Save errors that occur during initialization
	errors = Vector{Exception}()
	SetErrorCallback(err -> push!(errors, err))

	try
		Init()
	catch err
		push!(errors, err)
	end

	# Without a display server (headless CI, cluster nodes, batch jobs) the
	# default platform fails and loading the package would throw. Fall back
	# to the NULL platform so the package still loads; windows cannot be
	# created there, and `GetPlatform() == PLATFORM_NULL` lets downstream
	# code detect that it is headless. An explicitly requested platform is
	# honored as stated: if JULIA_GLFW_PLATFORM is set and does not work,
	# loading fails rather than being second-guessed.
	if !is_initialized() && !haskey(ENV, "JULIA_GLFW_PLATFORM") && PlatformSupported(PLATFORM_NULL)
		try
			Init(platform = PLATFORM_NULL)
			@warn "GLFW could not connect to a display and fell back to its NULL platform: " *
			      "the package is usable, but windows cannot be created or shown. Detect this " *
			      "with `GLFW.GetPlatform() == GLFW.PLATFORM_NULL`. To make a missing display " *
			      "fatal again, set the JULIA_GLFW_PLATFORM environment variable to the " *
			      "required platform (e.g. \"x11\")."
		catch err
			push!(errors, err)
		end
	end

	SetErrorCallback(throw)

	if is_initialized()
		atexit(Terminate)
		for err in errors
			@warn err  # Warn about any non-fatal errors that may have occurred during initialization
		end
	else
		throw(errors)  # Throw fatal errors
	end
end

end
