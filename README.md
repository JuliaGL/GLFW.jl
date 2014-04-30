GLFW.jl
=======

[GLFW][1] bindings for [Julia][2]. GLFW is a multi-platform library for opening a window, creating an [OpenGL][3] context, and managing input.

See the [GLFW documentation][4] for detailed instructions on how to use the library.

[1]: http://www.glfw.org/
[2]: http://julialang.org/
[3]: https://wikipedia.org/wiki/OpenGL
[4]: http://www.glfw.org/documentation.html

Minimal Window Example
----------------------
```julia
import GLFW

GLFW.Init()
window = GLFW.CreateWindow(800, 600, "GLFW.jl")
while !GLFW.WindowShouldClose(window) && !GLFW.GetKey(window, GLFW.KEY_ESCAPE)
	GLFW.SwapBuffers(window)
	GLFW.PollEvents()
end
GLFW.DestroyWindow(window)
GLFW.Terminate()
```
