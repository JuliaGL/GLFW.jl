import GLFW

GLFW.Init()
GLFW.OpenWindow(0, 0, 0, 0, 0, 0, 0, 0, GLFW.WINDOW)
GLFW.SetWindowTitle("GLFW for Julia")

function close_cb()
	println("window closed")
	return convert(Cint, 1)
end
GLFW.SetWindowCloseCallback(close_cb)

function size_cb(w::Cint, h::Cint)
	println("window size: ", h, "x", w)
	return
end
GLFW.SetWindowSizeCallback(size_cb)

function key_cb(key::Cint, action::Cint)
	if '!' <= key && key <= '~'
		key = convert(Char, key)
		key = string("'", key, "'")
	end
	println("key ", action == 1 ? "dn" : "up", ": ", key)
	return
end
GLFW.SetKeyCallback(key_cb)

function char_cb(key::Cint, action::Cint)
	key = convert(Char, key)
	key = string("'", key, "'")
	println("char ", action == 1 ? "dn" : "up", ": ", key)
	return
end
GLFW.SetCharCallback(char_cb)

function mouse_button_cb(button::Cint, action::Cint)
	println("mouse button ", action == 1 ? "dn" : "up", ": ", button)
	return
end
GLFW.SetMouseButtonCallback(mouse_button_cb)

function mouse_pos_cb(x::Cint, y::Cint)
	println("mouse pos: ", x, ", ", y)
	return
end
GLFW.SetMousePosCallback(mouse_pos_cb)

function mouse_wheel_cb(pos::Cint)
	println("mouse wheel: ", pos)
	return
end
GLFW.SetMouseWheelCallback(mouse_wheel_cb)

while GLFW.GetWindowParam(GLFW.OPENED)
	GLFW.SwapBuffers()
end

