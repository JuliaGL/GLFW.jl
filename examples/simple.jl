import GLFW

# Initialize the library
GLFW.Init()

# Create a windowed mode window and its OpenGL context
window = GLFW.CreateWindow(640, 480, "GLFW.jl", C_NULL, C_NULL)

# Make the window's context current
GLFW.MakeContextCurrent(window)

# Loop until the user closes the window
while GLFW.WindowShouldClose(window) == 0

	# Render here

	# Swap front and back buffers
	GLFW.SwapBuffers(window)

	# Poll for and process events
	GLFW.PollEvents()
end

GLFW.Terminate()