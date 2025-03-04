# GLFW.jl

[![CI](https://github.com/JuliaGL/GLFW.jl/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/JuliaGL/GLFW.jl/actions/workflows/ci.yml)


[Julia][julia] interface to [GLFW 3][glfw], a multi-platform library for creating windows with [OpenGL][opengl] or OpenGL ES contexts and receiving many kinds of input. GLFW has native support for Windows, OS X and many Unix-like systems using the X Window System, such as Linux and FreeBSD.

[julia]:  https://julialang.org
[glfw]:   https://www.glfw.org
[opengl]: https://wikipedia.org/wiki/OpenGL


Example
-------

```julia
using GLFW

# Create a window and its OpenGL context
window = GLFW.CreateWindow(640, 480, "GLFW.jl")

# Make the window's context current
GLFW.MakeContextCurrent(window)

# Loop until the user closes the window
while !GLFW.WindowShouldClose(window)

	# Render here

	# Swap front and back buffers
	GLFW.SwapBuffers(window)

	# Poll for and process events
	GLFW.PollEvents()
end

GLFW.DestroyWindow(window)
```

Interface
---------

Read the [GLFW documentation][docs] for detailed instructions on how to use the library. The Julia interface is almost identical to the underlying C interface, with a few notable differences:

* Clipboard (`glfwGetClipboard`, `glfwSetClipboard`) and time (`glfwGetTime`, `glfwSetTime`) functions have been omitted because Julia's standard library already supports similar functionality.
* `glfwInit` and `glfwTerminate` are called automatically using the `__init__` and `atexit` functions. While it is okay to still call them explicitly, it is redundant and not required.
* Thread restrictions are explicitly checked and throw errors when they are not respected. This can be turned off by setting `GLFW.ENABLE_THREAD_ASSERTIONS[] = false` or by setting an environment variable of the same name.

[docs]: https://www.glfw.org/docs/latest/


Footnotes
---------

* Special thanks to [@afterwise](https://github.com/afterwise) for writing an early implementation of GLFW 3 support.
