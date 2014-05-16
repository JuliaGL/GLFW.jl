module GLFW

const lib = find_library(["glfw3", "libglfw3", "glfw", "libglfw"], [Pkg.dir("GLFW/deps")])
if isempty(lib)
	error("could not find GLFW library")
end

include("util.jl")

function GetVersion()
	major, minor, rev = Cint[0], Cint[0], Cint[0]
	ccall( (:glfwGetVersion, lib), Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), major, minor, rev)
	VersionNumber(major[1], minor[1], rev[1])
end
const VERSION = GetVersion()

try
	include(string("glfw", VERSION.major, ".jl"))
catch
	error("GLFW $VERSION is not supported")
end

if isdefined(:SetErrorCallback)
	SetErrorCallback((code, desc) -> error(bytestring(desc)))
end

info(string("loaded GLFW ", isdefined(:GetVersionString) ? GetVersionString() : VERSION, " from $lib"))

if VERSION < VersionNumber(3)
	warn("GLFW $VERSION is outdated, consider upgrading to a newer version")
end

end
