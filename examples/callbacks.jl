import GLFW

GLFW.Init()
window = GLFW.CreateWindow(800, 600, "GLFW Callback Test")

function close_cb(win::GLFW.Window)
	println("window closed")
	return
end
GLFW.SetWindowCloseCallback(window, close_cb)

function size_cb(win::GLFW.Window, w::Cint, h::Cint)
	println("window size: ", h, "x", w)
	return
end
GLFW.SetWindowSizeCallback(window, size_cb)

function key_cb(win::GLFW.Window, key::Cint, scancode::Cint, action::Cint, mods::Cint)
	if '!' <= key && key <= '~'
		key = convert(Char, key)
		key = string("'", key, "'")
	end
	println("key ", action == 1 ? "dn" : "up", ": ", key)
	return
end
GLFW.SetKeyCallback(window, key_cb)

function char_cb(win::GLFW.Window, key::Cuint)
	c = convert(Char, key)
	c = string("'", c, "'")
	println("char: ", c)
	return
end
GLFW.SetCharCallback(window, char_cb)

function mouse_button_cb(win::GLFW.Window, button::Cint, action::Cint, mods::Cint)
	println("mouse button ", action == 1 ? "dn" : "up", ": ", button)
	return
end
GLFW.SetMouseButtonCallback(window, mouse_button_cb)

function cursor_pos_cb(win::GLFW.Window, x::Cdouble, y::Cdouble)
	println("cursor pos: ", x, ", ", y)
	return
end
GLFW.SetCursorPosCallback(window, cursor_pos_cb)

function scroll_cb(win::GLFW.Window, xoff::Cdouble, yoff::Cdouble)
	println("scroll: ", xoff, "x", yoff)
	return
end
GLFW.SetScrollCallback(window, scroll_cb)

while !GLFW.WindowShouldClose(window)
	GLFW.SwapBuffers(window)
	GLFW.PollEvents()
end

GLFW.Terminate()

