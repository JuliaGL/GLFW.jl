import GLFW
using Base.Test

# GLFWError uses enum for known error code
@test isa(GLFWError(GLFW.NOT_INITIALIZED, "").code, GLFW.ErrorCode)
@test GLFWError(0x00010001, "").code == GLFW.NOT_INITIALIZED

# GLFWError uses integer for unrecognized error code
@test isa(GLFWError(0xDEADBEEF, "").code, Integer)

if !haskey(ENV, "TRAVIS")
	include("windowclose.jl")
end
