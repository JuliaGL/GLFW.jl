#************************************************************************
# Input handling definitions
#************************************************************************

# Key and button state/action definitions
const RELEASE          = 0
const PRESS            = 1

# Keyboard key definitions: 8-bit ISO-8859-1 (Latin 1) encoding is used
# for printable keys (such as A-Z, 0-9 etc), and values above 256
# represent special (non-printable) keys (e.g. F1, Page Up etc).
const KEY_UNKNOWN      = -1
const KEY_SPACE        = 32
const KEY_SPECIAL      = 256
const KEY_ESC          = (KEY_SPECIAL+1)
const KEY_F1           = (KEY_SPECIAL+2)
const KEY_F2           = (KEY_SPECIAL+3)
const KEY_F3           = (KEY_SPECIAL+4)
const KEY_F4           = (KEY_SPECIAL+5)
const KEY_F5           = (KEY_SPECIAL+6)
const KEY_F6           = (KEY_SPECIAL+7)
const KEY_F7           = (KEY_SPECIAL+8)
const KEY_F8           = (KEY_SPECIAL+9)
const KEY_F9           = (KEY_SPECIAL+10)
const KEY_F10          = (KEY_SPECIAL+11)
const KEY_F11          = (KEY_SPECIAL+12)
const KEY_F12          = (KEY_SPECIAL+13)
const KEY_F13          = (KEY_SPECIAL+14)
const KEY_F14          = (KEY_SPECIAL+15)
const KEY_F15          = (KEY_SPECIAL+16)
const KEY_F16          = (KEY_SPECIAL+17)
const KEY_F17          = (KEY_SPECIAL+18)
const KEY_F18          = (KEY_SPECIAL+19)
const KEY_F19          = (KEY_SPECIAL+20)
const KEY_F20          = (KEY_SPECIAL+21)
const KEY_F21          = (KEY_SPECIAL+22)
const KEY_F22          = (KEY_SPECIAL+23)
const KEY_F23          = (KEY_SPECIAL+24)
const KEY_F24          = (KEY_SPECIAL+25)
const KEY_F25          = (KEY_SPECIAL+26)
const KEY_UP           = (KEY_SPECIAL+27)
const KEY_DOWN         = (KEY_SPECIAL+28)
const KEY_LEFT         = (KEY_SPECIAL+29)
const KEY_RIGHT        = (KEY_SPECIAL+30)
const KEY_LSHIFT       = (KEY_SPECIAL+31)
const KEY_RSHIFT       = (KEY_SPECIAL+32)
const KEY_LCTRL        = (KEY_SPECIAL+33)
const KEY_RCTRL        = (KEY_SPECIAL+34)
const KEY_LALT         = (KEY_SPECIAL+35)
const KEY_RALT         = (KEY_SPECIAL+36)
const KEY_TAB          = (KEY_SPECIAL+37)
const KEY_ENTER        = (KEY_SPECIAL+38)
const KEY_BACKSPACE    = (KEY_SPECIAL+39)
const KEY_INSERT       = (KEY_SPECIAL+40)
const KEY_DEL          = (KEY_SPECIAL+41)
const KEY_PAGEUP       = (KEY_SPECIAL+42)
const KEY_PAGEDOWN     = (KEY_SPECIAL+43)
const KEY_HOME         = (KEY_SPECIAL+44)
const KEY_END          = (KEY_SPECIAL+45)
const KEY_KP_0         = (KEY_SPECIAL+46)
const KEY_KP_1         = (KEY_SPECIAL+47)
const KEY_KP_2         = (KEY_SPECIAL+48)
const KEY_KP_3         = (KEY_SPECIAL+49)
const KEY_KP_4         = (KEY_SPECIAL+50)
const KEY_KP_5         = (KEY_SPECIAL+51)
const KEY_KP_6         = (KEY_SPECIAL+52)
const KEY_KP_7         = (KEY_SPECIAL+53)
const KEY_KP_8         = (KEY_SPECIAL+54)
const KEY_KP_9         = (KEY_SPECIAL+55)
const KEY_KP_DIVIDE    = (KEY_SPECIAL+56)
const KEY_KP_MULTIPLY  = (KEY_SPECIAL+57)
const KEY_KP_SUBTRACT  = (KEY_SPECIAL+58)
const KEY_KP_ADD       = (KEY_SPECIAL+59)
const KEY_KP_DECIMAL   = (KEY_SPECIAL+60)
const KEY_KP_EQUAL     = (KEY_SPECIAL+61)
const KEY_KP_ENTER     = (KEY_SPECIAL+62)
const KEY_KP_NUM_LOCK  = (KEY_SPECIAL+63)
const KEY_CAPS_LOCK    = (KEY_SPECIAL+64)
const KEY_SCROLL_LOCK  = (KEY_SPECIAL+65)
const KEY_PAUSE        = (KEY_SPECIAL+66)
const KEY_LSUPER       = (KEY_SPECIAL+67)
const KEY_RSUPER       = (KEY_SPECIAL+68)
const KEY_MENU         = (KEY_SPECIAL+69)
const KEY_LAST         = KEY_MENU

# Mouse button definitions
const MOUSE_BUTTON_1      = 0
const MOUSE_BUTTON_2      = 1
const MOUSE_BUTTON_3      = 2
const MOUSE_BUTTON_4      = 3
const MOUSE_BUTTON_5      = 4
const MOUSE_BUTTON_6      = 5
const MOUSE_BUTTON_7      = 6
const MOUSE_BUTTON_8      = 7
const MOUSE_BUTTON_LAST   = MOUSE_BUTTON_8

# Mouse button aliases
const MOUSE_BUTTON_LEFT   = MOUSE_BUTTON_1
const MOUSE_BUTTON_RIGHT  = MOUSE_BUTTON_2
const MOUSE_BUTTON_MIDDLE = MOUSE_BUTTON_3

# Joystick identifiers
const JOYSTICK_1          = 0
const JOYSTICK_2          = 1
const JOYSTICK_3          = 2
const JOYSTICK_4          = 3
const JOYSTICK_5          = 4
const JOYSTICK_6          = 5
const JOYSTICK_7          = 6
const JOYSTICK_8          = 7
const JOYSTICK_9          = 8
const JOYSTICK_10         = 9
const JOYSTICK_11         = 10
const JOYSTICK_12         = 11
const JOYSTICK_13         = 12
const JOYSTICK_14         = 13
const JOYSTICK_15         = 14
const JOYSTICK_16         = 15
const JOYSTICK_LAST       = JOYSTICK_16


#************************************************************************
# Other definitions
#************************************************************************

# glfwOpenWindow modes
const WINDOW                = 0x00010001
const FULLSCREEN            = 0x00010002

# glfwGetWindowParam tokens
const OPENED                = 0x00020001
const ACTIVE                = 0x00020002
const ICONIFIED             = 0x00020003
const ACCELERATED           = 0x00020004
const RED_BITS              = 0x00020005
const GREEN_BITS            = 0x00020006
const BLUE_BITS             = 0x00020007
const ALPHA_BITS            = 0x00020008
const DEPTH_BITS            = 0x00020009
const STENCIL_BITS          = 0x0002000A

# The following constants are used for both glfwGetWindowParam
# and glfwOpenWindowHint
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

# OPENGL_PROFILE tokens
const OPENGL_CORE_PROFILE   = 0x00050001
const OPENGL_COMPAT_PROFILE = 0x00050002

# glfwEnable/glfwDisable tokens
const MOUSE_CURSOR          = 0x00030001
const STICKY_KEYS           = 0x00030002
const STICKY_MOUSE_BUTTONS  = 0x00030003
const SYSTEM_KEYS           = 0x00030004
const KEY_REPEAT            = 0x00030005
const AUTO_POLL_EVENTS      = 0x00030006

# glfwGetJoystickParam tokens
const PRESENT               = 0x00050001
const AXES                  = 0x00050002
const BUTTONS               = 0x00050003


#************************************************************************
# Types
#************************************************************************

# The video mode structure used by glfwGetVideoModes()
immutable VidMode
	width::Cint
	height::Cint
	redbits::Cint
	bluebits::Cint
	greenbits::Cint
end

#************************************************************************
# Functions
#************************************************************************

# GLFW initialization and termination
function Init()
	status = ccall( (:glfwInit, lib), Cint, ())
	if status != 1
		error("initialization failed")
	end
end
Terminate() = ccall( (:glfwTerminate, lib), Void, ())

# Window handling
function OpenWindow(width::Integer, height::Integer, redbits::Integer,
	greenbits::Integer, bluebits::Integer, alphabits::Integer,
	depthbits::Integer, stencilbits::Integer, mode::Integer)

	status = ccall( (:glfwOpenWindow, lib), Cint,
		(Cint, Cint, Cint, Cint, Cint, Cint, Cint, Cint, Cint),
		width, height, redbits, greenbits, bluebits, alphabits, depthbits,
		stencilbits, mode)
	if status != 1
		error("window creation failed")
	end
end

OpenWindowHint(target::Integer, hint::Integer) = ccall( (:glfwOpenWindowHint, lib), Void, (Cuint, Cuint), target, hint)
CloseWindow() = ccall( (:glfwCloseWindow, lib), Void, ())
SetWindowTitle(title::String) = ccall( (:glfwSetWindowTitle, lib), Void, (Ptr{Cchar},), bytestring(title))

function GetWindowSize()
	width, height = Cint[0], Cint[0]
	ccall( (:glfwGetWindowSize, lib), Void, (Ptr{Cint}, Ptr{Cint}), width, height)
	(width[1], height[1])
end

SetWindowSize(width::Integer, height::Integer) = ccall( (:glfwSetWindowSize, lib), Void, (Cuint, Cuint), width, height)
SetWindowPos(x::Integer, y::Integer) = ccall( (:glfwSetWindowPos, lib), Void, (Cuint, Cuint), x, y)
IconifyWindow() = ccall( (:glfwIconifyWindow, lib), Void, ())
RestoreWindow() = ccall( (:glfwRestoreWindow, lib), Void, ())
SwapBuffers() = ccall( (:glfwSwapBuffers, lib), Void, ())
SwapInterval(interval::Integer) = ccall( (:glfwSwapInterval, lib), Void, (Cuint,), interval)

function GetWindowParam(param::Integer)
	value = ccall( (:glfwGetWindowParam, lib), Cuint, (Cuint,), param)
	if param in (OPENED, ACTIVE, ICONIFIED, ACCELERATED, STEREO, WINDOW_NO_RESIZE, OPENGL_FORWARD_COMPAT, OPENGL_DEBUG_CONTEXT)
		value = bool(value)
	end
	value
end

@SetCallback(WindowSize, Void, (Cint, Cint))
@SetCallback(WindowClose, Cint, ())
@SetCallback(WindowRefresh, Void, ())

# Video mode functions
function GetVideoModes(maxcount::Integer=100)
	modes = Array(VidMode, maxcount)
	count = ccall( (:glfwGetVideoModes, lib), Cuint, (Ptr{VidMode}, Cuint), modes, maxcount)
	modes[1:count]
end

function GetDesktopMode()
	mode = Array(VidMode, 1)
	ccall( (:glfwGetDesktopMode, lib), Void, (Ptr{VidMode},), mode)
	mode[1]
end

# Input handling
PollEvents() = ccall( (:glfwPollEvents, lib), Void, ())
WaitEvents() = ccall( (:glfwWaitEvents, lib), Void, ())
GetKey(key::Integer) = ccall( (:glfwGetKey, lib), Cuint, (Cuint,), key) == PRESS
GetMouseButton(button::Integer) = ccall( (:glfwGetMouseButton, lib), Cuint, (Cuint,), button) == PRESS

function GetMousePos()
	xpos = Cint[0]
	ypos = Cint[0]
	ccall( (:glfwGetMousePos, lib), Void, (Ptr{Cint}, Ptr{Cint}), xpos, ypos)
	(xpos[1], ypos[1])
end

SetMousePos(xpos::Integer, ypos::Integer) = ccall( (:glfwSetMousePos, lib), Void, (Cuint, Cuint), xpos, ypos)
GetMouseWheel() = ccall( (:glfwGetMouseWheel, lib), Cuint, ())
SetMouseWheel(pos::Integer) = ccall( (:glfwSetMouseWheel, lib), Void, (Cuint,), pos)
@SetCallback(Key, Void, (Cint, Cint))
@SetCallback(Char, Void, (Cint, Cint))
@SetCallback(MouseButton, Void, (Cint, Cint))
@SetCallback(MousePos, Void, (Cint, Cint))
@SetCallback(MouseWheel, Void, (Cint,))

# Joystick input
function GetJoystickParam(joy::Integer, param::Integer)
	value = ccall( (:glfwGetJoystickParam, lib), Cuint, (Cuint, Cuint), joy, param)
	if param == PRESENT
		value = bool(value)
	end
	value
end

function GetJoystickPos(joy::Integer, numaxes::Integer=GetJoystickParam(joy, AXES))
	axes = Array(Cfloat, numaxes)
	num = ccall( (:glfwGetJoystickPos, lib), Cuint, (Cuint, Ptr{Cfloat}, Cuint), joy, axes, numaxes)
	axes[1:num]
end

function GetJoystickButtons(joy::Integer, numbuttons::Integer=GetJoystickParam(joy, BUTTONS))
	buttons = Array(Cuchar, numbuttons)
	num = ccall( (:glfwGetJoystickButtons, lib), Cuint, (Cuint, Ptr{Cuchar}, Cuint), joy, buttons, numbuttons)
	buttons[1:num]
end

# Extension support
ExtensionSupported(extension::String) = bool(ccall( (:glfwExtensionSupported, lib), Cuint, (Ptr{Cchar},), bytestring(extension)))

# Enable/disable functions
Enable(token::Integer) = ccall( (:glfwEnable, lib), Void, (Cuint,), token)
Disable(token::Integer) = ccall( (:glfwDisable, lib), Void, (Cuint,), token)
