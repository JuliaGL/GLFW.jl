# GLFW.jl 

[![CI](https://github.com/JuliaGL/GLFW.jl/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/JuliaGL/GLFW.jl/actions/workflows/ci.yml)
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://juliagl.github.io/GLFW.jl/stable)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliagl.github.io/GLFW.jl/dev)

This is a[Julia][julia] interface to [GLFW 3][glfw], see the
[docs](https://juliagl.github.io/GLFW.jl/stable) for more information.

[julia]:  https://julialang.org
[glfw]:   https://www.glfw.org
[opengl]: https://wikipedia.org/wiki/OpenGL


## Example
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
