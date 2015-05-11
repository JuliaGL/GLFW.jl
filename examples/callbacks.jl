import GLFW

GLFW.Init()
window = GLFW.CreateWindow(800, 600, "GLFW Callback Test")
GLFW.MakeContextCurrent(window)

GLFW.SetWindowCloseCallback(window, () -> println("window closed"))
GLFW.SetWindowSizeCallback(window, (w, h) -> println("window size: $h x $w"))

GLFW.SetKeyCallback(window, (key, scancode, action, mods) -> begin
	if '!' <= key && key <= '~'
		key = convert(Char, key)
		key = string("'", key, "'")
	end
	println("key ", action == 1 ? "dn" : "up", ": $key")
end)

GLFW.SetCharCallback(window, (c) -> println("char: '$(convert(Char, c))'"))
GLFW.SetMouseButtonCallback(window, (button, action, mods) ->
	println("mouse button ", action == 1 ? "dn" : "up", ": $button"))
GLFW.SetCursorPosCallback(window, (x, y) -> println("cursor pos: $x, $y"))
GLFW.SetScrollCallback(window, (xoff, yoff) -> println("scroll: $xoff, $yoff"))

glClear() = ccall(@eval(GLFW.GetProcAddress("glClear")), Void, (Cuint,), 0x00004000)

gc() # Force garbage collection so that improper reference management is more apparent via crashes

frames = 0
seconds = @elapsed while !GLFW.WindowShouldClose(window)
	glClear()
	GLFW.SwapBuffers(window)
	GLFW.PollEvents()
	frames += 1
end
println(frames / seconds, " fps")

GLFW.Terminate()
