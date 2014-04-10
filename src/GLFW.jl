module GLFW

const lib = find_library(["glfw3", "libglfw3", "glfw", "libglfw"])

if isempty(lib)
	error("could not find GLFW library")
end

include("common.jl")

version = GetVersion()

if version[1] == 2
	include("glfw2.jl")
	info("loaded GLFW ", join(version, '.'))
	warn("GLFW 2 is outdated; consider upgrading to GLFW 3")
elseif version[1] == 3
	include("glfw3.jl")
	info("loaded GLFW ", GetVersionString())
else
	error("GLFW ", join(version, '.'), " is not supported")
end

end
