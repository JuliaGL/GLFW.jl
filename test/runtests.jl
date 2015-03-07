import GLFW

travis = haskey(ENV, "TRAVIS") && ENV["TRAVIS"] == "true"

try
	GLFW.Init()
catch e
	if travis && contains(e.msg, "/dev/input: No such file or directory")
		warn(e.msg)
	else
		rethrow()
	end
end
window = GLFW.CreateWindow(640, 480, "GLFW.jl Test")
GLFW.MakeContextCurrent(window)
GLFW.SwapBuffers(window)
GLFW.PollEvents()
GLFW.DestroyWindow(window)
GLFW.Terminate()
