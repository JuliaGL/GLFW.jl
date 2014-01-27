module GLFW

const lib = "libglfw"

################################################################################
#   Initialization and Termination
################################################################################

function Init()
	ret = ccall( (:glfwInit, lib), Cint, ())
	if ret != 1
		error("initialization failed")
	end
end

function Terminate()
	ccall( (:glfwTerminate, lib), Void, ())
end

################################################################################
#   Window Handling
################################################################################

function OpenWindow(width::Integer, height::Integer, redbits::Integer,
	greenbits::Integer, bluebits::Integer, alphabits::Integer,
	depthbits::Integer, stencilbits::Integer, mode::Integer)

	ret = ccall( (:glfwOpenWindow, lib), Cint,
		(Cint, Cint, Cint, Cint, Cint, Cint, Cint, Cint, Cint),
		width, height, redbits, greenbits, bluebits, alphabits, depthbits,
		stencilbits, mode)
	if ret != 1
		error("window creation failed")
	end
end

# OpenWindow modes
const WINDOW     = 0x00010001
const FULLSCREEN = 0x00010002

function OpenWindowHint(target::Integer, hint::Integer)
	ccall( (:glfwOpenWindowHint, lib), Void, (Cint, Cint), target, hint)
end

# OpenWindowHint targets and GetWindowParam parameters
const REFRESH_RATE          = 0x0002000B
const ACCUM_RED_BITS        = 0x0002000C
const ACCUM_GREEN_BITS      = 0x0002000D
const ACCUM_BLUE_BITS       = 0x0002000E
const ACCUM_ALPHA_BITS      = 0x0002000F
const AUX_BUFFERS           = 0x00020010
const STEREO                = 0x00020011
const WINDOW_NO_RESIZE      = 0x00020012
const FSAA_SAMPLES          = 0x00020013
const OPENGL_VERSION_MAJOR  = 0x00020014
const OPENGL_VERSION_MINOR  = 0x00020015
const OPENGL_FORWARD_COMPAT = 0x00020016
const OPENGL_DEBUG_CONTEXT  = 0x00020017
const OPENGL_PROFILE        = 0x00020018

# OPENGL_PROFILE hints
const OPENGL_CORE_PROFILE   = 0x00050001
const OPENGL_COMPAT_PROFILE = 0x00050002

function CloseWindow()
	ccall( (:glfwCloseWindow, lib), Void, ())
end

function SetWindowCloseCallback(callback::Function)
	cfunc = cfunction(callback, Cint, ())
	ccall( (:glfwSetWindowCloseCallback, lib), Void, (Ptr{Void},), cfunc)
end

function SetWindowTitle(title::String)
	ccall( (:glfwSetWindowTitle, lib), Void, (Ptr{Uint8},), bytestring(title))
end

function SetWindowSizeCallback(callback::Function)
	cfunc = cfunction(callback, Void, (Cint, Cint))
	ccall( (:glfwSetWindowSizeCallback, lib), Void, (Ptr{Void},), cfunc)
end

function GetWindowParam(param::Integer)
	ret = ccall( (:glfwGetWindowParam, lib), Cint, (Cint,), param)
	if contains(boolParams, param)
		return ret == 1
	else
		return ret
	end
end

# GetWindowParam parameters
const OPENED       = 0x00020001
const ACTIVE       = 0x00020002
const ICONIFIED    = 0x00020003
const ACCELERATED  = 0x00020004
const RED_BITS     = 0x00020005
const GREEN_BITS   = 0x00020006
const BLUE_BITS    = 0x00020007
const ALPHA_BITS   = 0x00020008
const DEPTH_BITS   = 0x00020009
const STENCIL_BITS = 0x0002000A

const boolParams = (OPENED, ACTIVE, ICONIFIED, ACCELERATED, STEREO,
	WINDOW_NO_RESIZE, OPENGL_FORWARD_COMPAT, OPENGL_DEBUG_CONTEXT)

function SwapBuffers()
	ccall( (:glfwSwapBuffers, lib), Void, ())
end

function SwapInterval(interval::Integer)
	ccall( (:glfwSwapInterval, lib), Void, (Cint,), interval)
end

################################################################################
#   Input Handling
################################################################################

function PollEvents()
	ccall( (:glfwPollEvents, lib), Void, ())
end

function GetKey(key::Integer)
	ccall( (:glfwGetKey, lib), Cint, (Cint,), key) == 1
end

# Keyboard key identifiers
const KEY_UNKNOWN     = -1
const KEY_SPACE       = 32
const KEY_SPECIAL     = 256
const KEY_ESC         = (KEY_SPECIAL+1)
const KEY_F1          = (KEY_SPECIAL+2)
const KEY_F2          = (KEY_SPECIAL+3)
const KEY_F3          = (KEY_SPECIAL+4)
const KEY_F4          = (KEY_SPECIAL+5)
const KEY_F5          = (KEY_SPECIAL+6)
const KEY_F6          = (KEY_SPECIAL+7)
const KEY_F7          = (KEY_SPECIAL+8)
const KEY_F8          = (KEY_SPECIAL+9)
const KEY_F9          = (KEY_SPECIAL+10)
const KEY_F10         = (KEY_SPECIAL+11)
const KEY_F11         = (KEY_SPECIAL+12)
const KEY_F12         = (KEY_SPECIAL+13)
const KEY_F13         = (KEY_SPECIAL+14)
const KEY_F14         = (KEY_SPECIAL+15)
const KEY_F15         = (KEY_SPECIAL+16)
const KEY_F16         = (KEY_SPECIAL+17)
const KEY_F17         = (KEY_SPECIAL+18)
const KEY_F18         = (KEY_SPECIAL+19)
const KEY_F19         = (KEY_SPECIAL+20)
const KEY_F20         = (KEY_SPECIAL+21)
const KEY_F21         = (KEY_SPECIAL+22)
const KEY_F22         = (KEY_SPECIAL+23)
const KEY_F23         = (KEY_SPECIAL+24)
const KEY_F24         = (KEY_SPECIAL+25)
const KEY_F25         = (KEY_SPECIAL+26)
const KEY_UP          = (KEY_SPECIAL+27)
const KEY_DOWN        = (KEY_SPECIAL+28)
const KEY_LEFT        = (KEY_SPECIAL+29)
const KEY_RIGHT       = (KEY_SPECIAL+30)
const KEY_LSHIFT      = (KEY_SPECIAL+31)
const KEY_RSHIFT      = (KEY_SPECIAL+32)
const KEY_LCTRL       = (KEY_SPECIAL+33)
const KEY_RCTRL       = (KEY_SPECIAL+34)
const KEY_LALT        = (KEY_SPECIAL+35)
const KEY_RALT        = (KEY_SPECIAL+36)
const KEY_TAB         = (KEY_SPECIAL+37)
const KEY_ENTER       = (KEY_SPECIAL+38)
const KEY_BACKSPACE   = (KEY_SPECIAL+39)
const KEY_INSERT      = (KEY_SPECIAL+40)
const KEY_DEL         = (KEY_SPECIAL+41)
const KEY_PAGEUP      = (KEY_SPECIAL+42)
const KEY_PAGEDOWN    = (KEY_SPECIAL+43)
const KEY_HOME        = (KEY_SPECIAL+44)
const KEY_END         = (KEY_SPECIAL+45)
const KEY_KP_0        = (KEY_SPECIAL+46)
const KEY_KP_1        = (KEY_SPECIAL+47)
const KEY_KP_2        = (KEY_SPECIAL+48)
const KEY_KP_3        = (KEY_SPECIAL+49)
const KEY_KP_4        = (KEY_SPECIAL+50)
const KEY_KP_5        = (KEY_SPECIAL+51)
const KEY_KP_6        = (KEY_SPECIAL+52)
const KEY_KP_7        = (KEY_SPECIAL+53)
const KEY_KP_8        = (KEY_SPECIAL+54)
const KEY_KP_9        = (KEY_SPECIAL+55)
const KEY_KP_DIVIDE   = (KEY_SPECIAL+56)
const KEY_KP_MULTIPLY = (KEY_SPECIAL+57)
const KEY_KP_SUBTRACT = (KEY_SPECIAL+58)
const KEY_KP_ADD      = (KEY_SPECIAL+59)
const KEY_KP_DECIMAL  = (KEY_SPECIAL+60)
const KEY_KP_EQUAL    = (KEY_SPECIAL+61)
const KEY_KP_ENTER    = (KEY_SPECIAL+62)
const KEY_KP_NUM_LOCK = (KEY_SPECIAL+63)
const KEY_CAPS_LOCK   = (KEY_SPECIAL+64)
const KEY_SCROLL_LOCK = (KEY_SPECIAL+65)
const KEY_PAUSE       = (KEY_SPECIAL+66)
const KEY_LSUPER      = (KEY_SPECIAL+67)
const KEY_RSUPER      = (KEY_SPECIAL+68)
const KEY_MENU        = (KEY_SPECIAL+69)
const KEY_LAST        = KEY_MENU

function GetMouseButton(button::Integer)
	ccall( (:glfwGetMouseButton, lib), Cint, (Cint,), button) == 1
end

# Mouse button definitions
const MOUSE_BUTTON_1    = 0
const MOUSE_BUTTON_2    = 1
const MOUSE_BUTTON_3    = 2
const MOUSE_BUTTON_4    = 3
const MOUSE_BUTTON_5    = 4
const MOUSE_BUTTON_6    = 5
const MOUSE_BUTTON_7    = 6
const MOUSE_BUTTON_8    = 7
const MOUSE_BUTTON_LAST = MOUSE_BUTTON_8

# Mouse button aliases
const MOUSE_BUTTON_LEFT   = MOUSE_BUTTON_1
const MOUSE_BUTTON_RIGHT  = MOUSE_BUTTON_2
const MOUSE_BUTTON_MIDDLE = MOUSE_BUTTON_3

function GetMousePos()
	xpos = Cint[0]
	ypos = Cint[0]
	ccall( (:glfwGetMousePos, lib), Void, (Ptr{Cint}, Ptr{Cint}), xpos, ypos)
	return (xpos[1], ypos[1])
end

function SetMousePos(x::Integer, y::Integer)
	ccall( (:glfwSetMousePos, lib), Void, (Cint, Cint), x, y)
end

function GetMouseWheel()
	ccall( (:glfwGetMouseWheel, lib), Cint, ())
end

function SetMouseWheel(pos::Integer)
	ccall( (:glfwSetMouseWheel, lib), Void, (Cint,), pos)
end

function SetKeyCallback(callback::Function)
	cfunc = cfunction(callback, Void, (Cint, Cint))
	ccall( (:glfwSetKeyCallback, lib), Void, (Ptr{Void},), cfunc)
end

function SetCharCallback(callback::Function)
	cfunc = cfunction(callback, Void, (Cint, Cint))
	ccall( (:glfwSetCharCallback, lib), Void, (Ptr{Void},), cfunc)
end

function SetMouseButtonCallback(callback::Function)
	cfunc = cfunction(callback, Void, (Cint, Cint))
	ccall( (:glfwSetMouseButtonCallback, lib), Void, (Ptr{Void},), cfunc)
end

function SetMousePosCallback(callback::Function)
	cfunc = cfunction(callback, Void, (Cint, Cint))
	ccall( (:glfwSetMousePosCallback, lib), Void, (Ptr{Void},), cfunc)
end

function SetMouseWheelCallback(callback::Function)
	cfunc = cfunction(callback, Void, (Cint,))
	ccall( (:glfwSetMouseWheelCallback, lib), Void, (Ptr{Void},), cfunc)
end

################################################################################
#   Miscellaneous
################################################################################

function Enable(token::Integer)
	ccall( (:glfwEnable, lib), Void, (Cint,), token)
end

function Disable(token::Integer)
	ccall( (:glfwDisable, lib), Void, (Cint,), token)
end

# Enable and disable tokens
const MOUSE_CURSOR         = 0x00030001
const STICKY_KEYS          = 0x00030002
const STICKY_MOUSE_BUTTONS = 0x00030003
const SYSTEM_KEYS          = 0x00030004
const KEY_REPEAT           = 0x00030005
const AUTO_POLL_EVENTS     = 0x00030006

end # module

