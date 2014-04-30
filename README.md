GLFW.jl
=======

[GLFW][1] bindings for [Julia][2]. GLFW is a multi-platform library for opening a window, creating an [OpenGL][3] context, and managing input.

See the [GLFW documentation][4] for detailed instructions on how to use the library.

[1]: http://www.glfw.org/
[2]: http://julialang.org/
[3]: https://wikipedia.org/wiki/OpenGL
[4]: http://www.glfw.org/documentation.html


Supported Versions
------------------

GLFW.jl supports multiple versions of the library, including 3.0.x and older 2.7.x. When the module is imported, it will search for a GLFW shared library with Julia's [`find_library`][5] function, detect the API version provided by the library, and then load the corresponding functions for that API version.

[5]: http://docs.julialang.org/en/latest/stdlib/base/#Base.find_library

Simple Window Example
---------------------
```julia
import GLFW

# Initialize the library
GLFW.Init()

# Create a windowed mode window and its OpenGL context
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
