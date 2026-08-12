using GLFW, Test

println(GLFW.GetVersionString())

# GLFWError uses enum for known error code
@test isa(GLFW.GLFWError(GLFW.NOT_INITIALIZED, "").code, GLFW.ErrorCode)
@test GLFW.GLFWError(0x00010001, "").code == GLFW.NOT_INITIALIZED

# GLFWError uses integer for unrecognized error code
@test isa(GLFW.GLFWError(0xDEADBEEF, "").code, Integer)

# https://github.com/JuliaGL/GLFW.jl/pull/225
@test GLFW.PRESS == true
@test true == GLFW.PRESS
@test GLFW.RELEASE == false
@test false == GLFW.RELEASE

if Sys.islinux()
	# Loading with no display must not throw: __init__ falls back to the
	# NULL platform (#169, #200, #253). Checked in a subprocess so this
	# process's initialized GLFW is not disturbed.
	base = `$(Base.julia_cmd()) --project=$(Base.active_project()) --startup-file=no`
	env = copy(ENV)
	delete!(env, "DISPLAY")
	delete!(env, "WAYLAND_DISPLAY")
	delete!(env, "JULIA_GLFW_PLATFORM")
	check = "using GLFW; print(GLFW.is_initialized() && GLFW.GetPlatform() == GLFW.PLATFORM_NULL)"
	@test read(setenv(`$base -e $check`, env), String) == "true"

	# An explicitly requested platform that cannot work must still fail.
	env["JULIA_GLFW_PLATFORM"] = "x11"
	failing = setenv(`$base -e "using GLFW"`, env)
	@test !success(pipeline(failing, stdout = devnull, stderr = devnull))
end

if !haskey(ENV, "CI")  # AppVeyor and Travis CI don't support OpenGL
	include("windowclose.jl")
end
