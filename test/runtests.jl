travis = get(ENV, "TRAVIS", "") == "true"

import GLFW

if !travis
	include("windowclose.jl")
end

# GLFWError uses enum for known error code
@test isa(GLFWError(GLFW.NOT_INITIALIZED, "").code, GLFW.ErrorCode)
@test GLFWError(0x00010001, "").code == GLFW.NOT_INITIALIZED

# GLFWError uses integer for unrecognized error code
@test isa(GLFWError(0xDEADBEEF, "").code, Integer)
