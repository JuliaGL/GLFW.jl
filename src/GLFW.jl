module GLFW

include("common.jl")

version = GetVersion()

if version[1] == 2
	include("glfw2.jl")
	info("GLFW ", join(version, '.'))
elseif version[1] == 3
	include("glfw3.jl")
	info("GLFW ", GetVersionString())
else
	error("GLFW ", join(version, '.'), " is not supported")
end

end

