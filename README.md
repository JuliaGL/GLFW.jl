GLFW.jl  [![Build Status][status]][travis]
=======

[Julia][julia] interface to [GLFW 3][glfw], a multi-platform library for creating windows with [OpenGL][opengl] or OpenGL ES contexts and receiving many kinds of input. GLFW has native support for Windows, OS X and many Unix-like systems using the X Window System, such as Linux and FreeBSD.

[julia]:  http://julialang.org/
[glfw]:   http://www.glfw.org/
[opengl]: https://wikipedia.org/wiki/OpenGL

[travis]: https://travis-ci.org/JuliaGL/GLFW.jl
[status]: https://travis-ci.org/JuliaGL/GLFW.jl.svg?branch=master


Example
-------

```julia
import GLFW

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
```


Interface
---------

Read the [GLFW documentation][docs] for detailed instructions on how to use the library. The Julia interface is almost identical to the underlying C interface, with a few notable differences:

* Clipboard (`glfwGetClipboard`, `glfwSetClipboard`) and time (`glfwGetTime`, `glfwSetTime`) functions have been omitted because Julia's standard library already supports similar functionality.
* `glfwInit` and `glfwTerminate` are called automatically using the `__init__` and `atexit` functions. While it is okay to still call them explicitly, it is redundant and not required.

[docs]: http://www.glfw.org/docs/latest/


Footnotes
---------
* While it is possible (and often convenient) to use closures or anonymous functions as callbacks, they are potentially less performant than using a top-level function.
* Special thanks to [@afterwise](https://github.com/afterwise) for writing an early implementation of GLFW 3 support.
