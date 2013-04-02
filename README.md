GLFW.jl
=======

[GLFW][1] bindings for [Julia][2]. GLFW is a multi-platform library for opening a window, creating an OpenGL context, and managing input.

See the [GLFW documentation][3] for detailed instructions on how to use the library.

[1]: http://www.glfw.org/
[2]: http://julialang.org/
[3]: http://www.glfw.org/documentation.html

Minimal Window Example
----------------------
```
import GLFW
GLFW.Init()
GLFW.OpenWindow(0, 0, 0, 0, 0, 0, 0, 0, GLFW.WINDOW)
while GLFW.GetWindowParam(GLFW.OPENED) && !GLFW.GetKey(GLFW.KEY_ESC)
  GLFW.SwapBuffers()
end
GLFW.CloseWindow()
GLFW.Terminate()
```
