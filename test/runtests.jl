using Base.Test

travis = get(ENV, "TRAVIS", "") == "true"

import GLFW

# test errors
ORIGINAL_IO = STDERR
io_rd, io_wr = redirect_stderr()
# should only warn
GLFW.handle_error(Cint(GLFW.PLATFORM_ERROR), "X11: RandR gamma ramp support seems broken")
warning = String(readavailable(io_rd))
close(io_rd)
err_stream = redirect_stderr(ORIGINAL_IO)

# Contains, to be resilient against spliced in color commands
@test contains(warning, """WARNING: GLFW reports the following error: X11: RandR gamma ramp support seems broken.
This can be ignored on a headless system.""")
@test_throws GLFW.GLFWError GLFW.handle_error(Cint(GLFW.PLATFORM_ERROR), "test")

if !travis
	include("windowclose.jl")
end
