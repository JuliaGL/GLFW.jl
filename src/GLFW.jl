module GLFW

include("util.jl")

const deps_path = Pkg.dir("GLFW/deps")
if !(deps_path in DL_LOAD_PATH)
	push!(DL_LOAD_PATH, deps_path)
end

const lib = find_library(["glfw3", "libglfw3", "glfw", "libglfw"])
if isempty(lib)
	error("could not find GLFW library")
end

# Retrieves the version of the GLFW library.
function GetVersion()
	major, minor, rev = Cint[0], Cint[0], Cint[0]
	ccall( (:glfwGetVersion, lib), Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), major, minor, rev)
	VersionNumber(major[1], minor[1], rev[1])
end

const VERSION = GetVersion()

if VERSION.major == 2
	include("glfw2.jl")
	info("loaded GLFW $VERSION")
	warn("GLFW 2 is outdated, consider upgrading to GLFW 3")
elseif VERSION.major == 3
	include("glfw3.jl")
	info("loaded GLFW ", GetVersionString())
	SetErrorCallback((code, desc) -> error(bytestring(desc)))
else
	error("GLFW $VERSION is not supported")
end

end
