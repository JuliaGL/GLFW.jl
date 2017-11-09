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
	include("callback.jl")
	include("glfw3.jl")
else
	error("GLFW $libversion is not supported")
end

<<<<<<< HEAD
function handle_error(int_code, description)
	code = ErrorCode(int_code)
	if code == PLATFORM_ERROR && (
			contains(description, "Failed to get display service port iterator") ||
			contains(description, "Failed to retrieve display name") ||
			contains(description, "RandR gamma ramp support seems broken") ||
			contains(description, "RandR monitor support seems broken") ||
			contains(description, "Failed to watch for joystick connections in") ||
			contains(description, "Failed to open joystick device directory")
		)
		# Workaround: downgrade Mac display name error to warning
		# https://github.com/glfw/glfw/issues/958
		#warn("GLFW reports the following error: $description.\nThis can be ignored on a headless system.")
	else
		throw(GLFWError(code, description))
	end
end
=======
pusherror!(collection) = (code, description) -> push!(collection, GLFWError(code, description))
throwerror(code, description) = throw(GLFWError(code, description))
>>>>>>> master

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
