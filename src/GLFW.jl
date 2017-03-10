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
function handle_error(code, description)
	if code == PLATFORM_ERROR && (
			contains(description, "Failed to get display service port iterator") ||
			contains(description, "Failed to retrieve display name") ||
			contains(description, "RandR gamma ramp support seems broken") ||
			contains(description, "Failed to watch for joystick connections in")
		)
		# Workaround: downgrade Mac display name error to warning
		# https://github.com/glfw/glfw/issues/958
		warn(ex)
	else
		throw(GLFWError(code, description))
	end
end

function __init__()
	SetErrorCallback(handle_error)
	GLFW.Init()
	atexit(GLFW.Terminate)
end

end
