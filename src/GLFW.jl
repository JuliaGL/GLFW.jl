module GLFW

const deps_path = Pkg.dir("GLFW/deps")
if !(deps_path in DL_LOAD_PATH)
	push!(DL_LOAD_PATH, deps_path)
end

const lib = find_library(["glfw3", "libglfw3", "glfw", "libglfw"])
if isempty(lib)
	error("could not find GLFW library")
end

include("common.jl")

const version = GetVersion()
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
