__precompile__()

module GLFW

include("../deps/deps.jl")

function GetVersion()
	major, minor, rev = Ref{Cint}(), Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetVersion, lib), Void, (Ref{Cint}, Ref{Cint}, Ref{Cint}), major, minor, rev)
	VersionNumber(major[], minor[], rev[])
end
const libversion = GetVersion()

if libversion.major == 3
	include("constants.jl")
	include("types.jl")
	include("callback.jl")
	include("functions.jl")
	include("extensions.jl")
else
	error("GLFW $libversion is not supported")
end

pusherror!(collection) = (code, description) -> push!(collection, GLFWError(code, description))
throwerror(code, description) = throw(GLFWError(code, description))

function __init__()
	initialized = false

	# Save errors that occur during initialization
	errors = Vector{Exception}()
	SetErrorCallback(pusherror!(errors))

	try
		initialized = GLFW.Init()
	catch err
		push!(errors, err)
	finally
		SetErrorCallback(throwerror)
	end

	if initialized
		atexit(GLFW.Terminate)
		for err in errors
			warn(err)  # Warn about any non-fatal errors that may have occurred during initialization
		end
	else
		throw(errors)  # Throw fatal errors
	end
end

end
