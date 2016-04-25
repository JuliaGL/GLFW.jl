__precompile__()

module GLFW

const lib = Libdl.find_library(["glfw3", "libglfw3", "glfw", "libglfw"], [Pkg.dir("GLFW/deps/usr$WORD_SIZE/lib")])
if isempty(lib)
	error("could not find GLFW library")
end
include_dependency(string(lib, ".", Libdl.dlext)) # Trigger recompilation if the library changes

function GetVersion()
	major, minor, rev = Ref{Cint}(), Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetVersion, lib), Void, (Ref{Cint}, Ref{Cint}, Ref{Cint}), major, minor, rev)
	VersionNumber(major[], minor[], rev[])
end
const VERSION = GetVersion()

if VERSION.major == 3
	include("callback.jl")
	include("glfw3.jl")
else
	error("GLFW $VERSION is not supported")
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
