module GLFW

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
	(major[1], minor[1], rev[1])
end

const (VERSION_MAJOR, VERSION_MINOR, VERSION_REVISION) = GetVersion()

if VERSION_MAJOR == 2
	include("glfw2.jl")
	info("loaded GLFW ", join(GetVersion(), '.'))
	warn("GLFW 2 is outdated; consider upgrading to GLFW 3")
elseif VERSION_MAJOR == 3
	include("glfw3.jl")
	info("loaded GLFW ", GetVersionString())
	SetErrorCallback(error)
else
	error("GLFW ", join(GetVersion(), '.'), " is not supported")
end

end
