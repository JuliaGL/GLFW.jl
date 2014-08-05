GLFW.jl  [![Build Status][status]][travis]
=======

[Julia][1] interface to [GLFW][2], a multi-platform library for creating windows with OpenGL contexts and managing input and events. GLFW has native support for Windows, OS X and many Unix-like systems using the X Window System, such as Linux and FreeBSD.

Read the [GLFW documentation][4] for detailed instructions on how to use the library.

[1]: http://julialang.org/
[2]: http://www.glfw.org/
[3]: https://wikipedia.org/wiki/OpenGL
[4]: http://www.glfw.org/documentation.html

[travis]: https://travis-ci.org/JuliaGL/GLFW.jl
[status]: https://travis-ci.org/JuliaGL/GLFW.jl.svg


Supported Versions
------------------

GLFW.jl supports multiple versions of GLFW, including 3.0.x and older 2.7.x. When imported, the module searches for a GLFW shared library with Julia's [`find_library`][5] function and then loads bindings based on the library version detected.

[5]: http://docs.julialang.org/en/latest/stdlib/base/#Base.find_library


Simple Window Example
---------------------

```julia
import GLFW

# Initialize the library
GLFW.Init()

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

GLFW.Terminate()
```


Footnotes
---------
* While it is possible (and often convenient) to use closures or anonymous functions as callbacks, they are potentially less performant than using a top-level function.
* Special thanks to [@afterwise](https://github.com/afterwise) for writing an early implementation of GLFW 3 support.
