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

immutable GLFWError <: Exception
    code::ErrorCode
    description::UTF8String
end
function Base.showerror(io::IO, e::GLFWError)
    print(io,
        "GLWF reported an error with the code: ",
        e.code, ".\n",
        "And the Description: ",
        e.description
    )
end
function error_callback(code, description)
    throw(GLFWError(ErrorCode(code), bytestring(description)))
end
function __init__()
	SetErrorCallback(error_callback)
	GLFW.Init()
	atexit(GLFW.Terminate)
end

end
