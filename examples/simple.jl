import GLFW

GLFW.Init()
window = GLFW.CreateWindow(800, 600, "GLFW.jl")
while !GLFW.WindowShouldClose(window) && !GLFW.GetKey(window, GLFW.KEY_ESCAPE)
	GLFW.SwapBuffers(window)
	GLFW.PollEvents()
end
GLFW.DestroyWindow(window)
GLFW.Terminate()