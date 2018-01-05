import GLFW

include("../src/compat.jl")

window = GLFW.CreateWindow(640, 480, "GLFW Callback Test")
GLFW.MakeContextCurrent(window)

# Window callbacks
GLFW.SetWindowCloseCallback(window, (_) -> println("window closed"))
GLFW.SetWindowPosCallback(window, (_, x, y) -> println("window position: $x, $y"))
GLFW.SetWindowSizeCallback(window, (_, w, h) -> println("window size: $h x $w"))
GLFW.SetWindowFocusCallback(window, (_, focused) -> println("window focus: $focused"))
GLFW.SetWindowIconifyCallback(window, (_, iconified) -> println("window iconify: $iconified"))

# Input callbacks
actiontext = Dict(
	GLFW.RELEASE => "released",
	GLFW.PRESS   => "pressed",
	GLFW.REPEAT  => "repeats"
)
GLFW.SetKeyCallback(window, (_, key, scancode, action, mods) -> begin
	name = get(GLFW.GetKeyName(key, scancode), "$key")
	println("key $name ", actiontext[action])
end)

GLFW.SetCharModsCallback(window, (_, c, mods) -> println("char: $c, mods: $mods"))
GLFW.SetMouseButtonCallback(window, (_, button, action, mods) ->
	println("mouse button $button ", actiontext[action]))
GLFW.SetCursorPosCallback(window, (_, x, y) -> println("cursor: $x, $y"))
GLFW.SetScrollCallback(window, (_, xoff, yoff) -> println("scroll: $xoff, $yoff"))

GLFW.SetDropCallback(window, (_, paths) -> println(paths))

glClear() = ccall(@eval(GLFW.GetProcAddress("glClear")), Cvoid, (Cuint,), 0x00004000)

gc() # Force garbage collection so that improper reference management is more apparent via crashes

try
	while !GLFW.WindowShouldClose(window)
		glClear()
		GLFW.SwapBuffers(window)
		GLFW.WaitEvents()
	end
finally
	GLFW.DestroyWindow(window)
end
