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

# mac/cocoa requires window events to be passed through the main thread
# because of this most GLFW functions should be called from the main thread
function require_main_thread()
	Threads.threadid() == 1 || throw(ThreadAssertionError(1))
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
	finally
		SetErrorCallback(throw)
	end

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
