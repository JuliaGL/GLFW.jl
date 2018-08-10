using GLFW

# Note: This was written as a quick test for multiwindow support.
# It is not a clean example (yet) of the proper way to do it.

windows = []
glClear = Dict{GLFW.Window, Function}()
for i in 1:3
	name = "Window $i"
	window = GLFW.CreateWindow(640, 480, name)
	GLFW.MakeContextCurrent(window)
	GLFW.SetMouseButtonCallback(window, (_, button, action, mods) -> begin
		if action == GLFW.PRESS
			println(name)
		end
	end)
	glClearFunc() = ccall(@eval(GLFW.GetProcAddress("glClear")), Cvoid, (Cuint,), 0x00004000)
	glClear[window] = glClearFunc 
	push!(windows, window)
end

GC.gc() # Force garbage collection so that improper reference management is more apparent via crashes

while !any(GLFW.WindowShouldClose, windows)
	for window in windows
		GLFW.MakeContextCurrent(window)
		glClear[window]()
		GLFW.SwapBuffers(window)
	end
	GLFW.WaitEvents()
end

for window in windows
	GLFW.DestroyWindow(window)
end
