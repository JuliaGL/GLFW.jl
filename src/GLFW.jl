__precompile__()

module GLFW

const lib = Libdl.find_library(["glfw3", "libglfw3", "glfw", "libglfw"], [Pkg.dir("GLFW/deps/usr$(Sys.WORD_SIZE)/lib")])
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

function __init__()
	SetErrorCallback((code, description) -> error(description))
	GLFW.Init()
	atexit(GLFW.Terminate)
end

end
