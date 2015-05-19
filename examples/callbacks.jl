import GLFW

GLFW.Init()
window = GLFW.CreateWindow(800, 600, "GLFW Callback Test")
GLFW.MakeContextCurrent(window)

GLFW.SetWindowCloseCallback(window, (_) -> println("window closed"))
GLFW.SetWindowSizeCallback(window, (_, w, h) -> println("window size: $h x $w"))

GLFW.SetKeyCallback(window, (_, key, scancode, action, mods) -> begin
	if '!' <= key && key <= '~'
		key = convert(Char, key)
		key = string("'", key, "'")
	end
	println("key ", action == 1 ? "dn" : "up", ": $key")
end)

GLFW.SetCharModsCallback(window, (_, c, mods) -> println("char: $c, mods: $mods"))
GLFW.SetMouseButtonCallback(window, (_, button, action, mods) ->
	println("mouse button ", action == 1 ? "dn" : "up", ": $button"))
GLFW.SetCursorPosCallback(window, (_, x, y) -> println("cursor pos: $x, $y"))
GLFW.SetScrollCallback(window, (_, xoff, yoff) -> println("scroll: $xoff, $yoff"))

GLFW.SetDropCallback(window, (_, paths) -> println(paths))

glClear() = ccall(@eval(GLFW.GetProcAddress("glClear")), Void, (Cuint,), 0x00004000)

gc() # Force garbage collection so that improper reference management is more apparent via crashes

while !GLFW.WindowShouldClose(window)
	glClear()
	GLFW.SwapBuffers(window)
	GLFW.WaitEvents()
end

GLFW.DestroyWindow(window)
GLFW.Terminate()
