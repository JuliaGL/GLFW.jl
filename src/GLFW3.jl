
module GLFW3

const VERSION_MAJOR = 3
const VERSION_MINOR = 0
const VERSION_REVISION = 4
const RELEASE = 0
const PRESS = 1
const REPEAT = 2
const KEY_SPACE = 32
const KEY_0 = 48
const KEY_1 = 49
const KEY_2 = 50
const KEY_3 = 51
const KEY_4 = 52
const KEY_5 = 53
const KEY_6 = 54
const KEY_7 = 55
const KEY_8 = 56
const KEY_9 = 57
const KEY_A = 65
const KEY_B = 66
const KEY_C = 67
const KEY_D = 68
const KEY_E = 69
const KEY_F = 70
const KEY_G = 71
const KEY_H = 72
const KEY_I = 73
const KEY_J = 74
const KEY_K = 75
const KEY_L = 76
const KEY_M = 77
const KEY_N = 78
const KEY_O = 79
const KEY_P = 80
const KEY_Q = 81
const KEY_R = 82
const KEY_S = 83
const KEY_T = 84
const KEY_U = 85
const KEY_V = 86
const KEY_W = 87
const KEY_X = 88
const KEY_Y = 89
const KEY_Z = 90
const KEY_ESCAPE = 256
const KEY_ENTER = 257
const KEY_TAB = 258
const KEY_BACKSPACE = 259
const KEY_INSERT = 260
const KEY_DELETE = 261
const KEY_RIGHT = 262
const KEY_LEFT = 263
const KEY_DOWN = 264
const KEY_UP = 265
const KEY_PAGE_UP = 266
const KEY_PAGE_DOWN = 267
const KEY_HOME = 268
const KEY_END = 269
const KEY_CAPS_LOCK = 280
const KEY_SCROLL_LOCK = 281
const KEY_NUM_LOCK = 282
const KEY_PRINT_SCREEN = 283
const KEY_PAUSE = 284
const KEY_F1 = 290
const KEY_F2 = 291
const KEY_F3 = 292
const KEY_F4 = 293
const KEY_F5 = 294
const KEY_F6 = 295
const KEY_F7 = 296
const KEY_F8 = 297
const KEY_F9 = 298
const KEY_F10 = 299
const KEY_F11 = 300
const KEY_F12 = 301
const KEY_F13 = 302
const KEY_F14 = 303
const KEY_F15 = 304
const KEY_F16 = 305
const KEY_F17 = 306
const KEY_F18 = 307
const KEY_F19 = 308
const KEY_F20 = 309
const KEY_F21 = 310
const KEY_F22 = 311
const KEY_F23 = 312
const KEY_F24 = 313
const KEY_F25 = 314
const KEY_KP_0 = 320
const KEY_KP_1 = 321
const KEY_KP_2 = 322
const KEY_KP_3 = 323
const KEY_KP_4 = 324
const KEY_KP_5 = 325
const KEY_KP_6 = 326
const KEY_KP_7 = 327
const KEY_KP_8 = 328
const KEY_KP_9 = 329
const KEY_KP_DECIMAL = 330
const KEY_KP_DIVIDE = 331
const KEY_KP_MULTIPLY = 332
const KEY_KP_SUBTRACT = 333
const KEY_KP_ADD = 334
const KEY_KP_ENTER = 335
const KEY_KP_EQUAL = 336
const KEY_LEFT_SHIFT = 340
const KEY_LEFT_CONTROL = 341
const KEY_LEFT_ALT = 342
const KEY_LEFT_SUPER = 343
const KEY_RIGHT_SHIFT = 344
const KEY_RIGHT_CONTROL = 345
const KEY_RIGHT_ALT = 346
const KEY_RIGHT_SUPER = 347
const KEY_MENU = 348
const KEY_LAST = KEY_MENU
const MOD_SHIFT = 0x0001
const MOD_CONTROL = 0x0002
const MOD_ALT = 0x0004
const MOD_SUPER = 0x0008
const MOUSE_BUTTON_1 = 0
const MOUSE_BUTTON_2 = 1
const MOUSE_BUTTON_3 = 2
const MOUSE_BUTTON_4 = 3
const MOUSE_BUTTON_5 = 4
const MOUSE_BUTTON_6 = 5
const MOUSE_BUTTON_7 = 6
const MOUSE_BUTTON_8 = 7
const MOUSE_BUTTON_LAST = MOUSE_BUTTON_8
const MOUSE_BUTTON_LEFT = MOUSE_BUTTON_1
const MOUSE_BUTTON_RIGHT = MOUSE_BUTTON_2
const MOUSE_BUTTON_MIDDLE = MOUSE_BUTTON_3
const JOYSTICK_1 = 0
const JOYSTICK_2 = 1
const JOYSTICK_3 = 2
const JOYSTICK_4 = 3
const JOYSTICK_5 = 4
const JOYSTICK_6 = 5
const JOYSTICK_7 = 6
const JOYSTICK_8 = 7
const JOYSTICK_9 = 8
const JOYSTICK_10 = 9
const JOYSTICK_11 = 10
const JOYSTICK_12 = 11
const JOYSTICK_13 = 12
const JOYSTICK_14 = 13
const JOYSTICK_15 = 14
const JOYSTICK_16 = 15
const JOYSTICK_LAST = JOYSTICK_16
const NOT_INITIALIZED = 0x00010001
const NO_CURRENT_CONTEXT = 0x00010002
const INVALID_ENUM = 0x00010003
const INVALID_VALUE = 0x00010004
const OUT_OF_MEMORY = 0x00010005
const API_UNAVAILABLE = 0x00010006
const VERSION_UNAVAILABLE = 0x00010007
const PLATFORM_ERROR = 0x00010008
const FORMAT_UNAVAILABLE = 0x00010009
const FOCUSED = 0x00020001
const ICONIFIED = 0x00020002
const RESIZABLE = 0x00020003
const VISIBLE = 0x00020004
const DECORATED = 0x00020005
const RED_BITS = 0x00021001
const GREEN_BITS = 0x00021002
const BLUE_BITS = 0x00021003
const ALPHA_BITS = 0x00021004
const DEPTH_BITS = 0x00021005
const STENCIL_BITS = 0x00021006
const ACCUM_RED_BITS = 0x00021007
const ACCUM_GREEN_BITS = 0x00021008
const ACCUM_BLUE_BITS = 0x00021009
const ACCUM_ALPHA_BITS = 0x0002100A
const AUX_BUFFERS = 0x0002100B
const STEREO = 0x0002100C
const SAMPLES = 0x0002100D
const SRGB_CAPABLE = 0x0002100E
const REFRESH_RATE = 0x0002100F
const CLIENT_API = 0x00022001
const CONTEXT_VERSION_MAJOR = 0x00022002
const CONTEXT_VERSION_MINOR = 0x00022003
const CONTEXT_REVISION = 0x00022004
const CONTEXT_ROBUSTNESS = 0x00022005
const OPENGL_FORWARD_COMPAT = 0x00022006
const OPENGL_DEBUG_CONTEXT = 0x00022007
const OPENGL_PROFILE = 0x00022008
const OPENGL_API = 0x00030001
const OPENGL_ES_API = 0x00030002
const NO_ROBUSTNESS = 0
const NO_RESET_NOTIFICATION = 0x00031001
const LOSE_CONTEXT_ON_RESET = 0x00031002
const OPENGL_ANY_PROFILE = 0
const OPENGL_CORE_PROFILE = 0x00032001
const OPENGL_COMPAT_PROFILE = 0x00032002
const CURSOR = 0x00033001
const STICKY_KEYS = 0x00033002
const STICKY_MOUSE_BUTTONS = 0x00033003
const CURSOR_NORMAL = 0x00034001
const CURSOR_HIDDEN = 0x00034002
const CURSOR_DISABLED = 0x00034003
const CONNECTED = 0x00040001
const DISCONNECTED = 0x00040002

macro glproc(cb)
	:(cfunction($cb, Void, ()))
end

typealias Monitor Ptr{Void}
typealias Window Ptr{Void}

macro errorfun(cb)
	:(cfunction($cb, Void, (Cint, Ptr{Cuchar})))
end

macro windowposfun(cb)
	:(cfunction($cb, Void, (Window, Cint, Cint)))
end

macro windowsizefun(cb)
	:(cfunction($cb, Void, (Window, Cint, Cint)))
end

macro windowclosefun(cb)
	:(cfunction($cb, Void, (Window)))
end

macro windowrefreshfun(cb)
	:(cfunction($cb, Void, (Window)))
end

macro windowfocusfun(cb)
	:(cfunction($cb, Void, (Window, Cint)))
end

macro windowiconifyfun(cb)
	:(cfunction($cb, Void, (Window, Cint)))
end

macro framebuffersizefun(cb)
	:(cfunction($cb, Void, (Window, Cint, Cint)))
end

macro mousebuttonfun(cb)
	:(cfunction($cb, Void, (Window, Cint, Cint, Cint)))
end

macro cursorposfun(cb)
	:(cfunction($cb, Void, (Window, Cdouble, Cdouble)))
end

macro cursorenterfun(cb)
	:(cfunction($cb, Void, (Window, Cint)))
end

macro scrollfun(cb)
	:(cfunction($cb, Void, (Window, Cdouble, Cdouble)))
end

macro keyfun(cb)
	:(cfunction($cb, Void, (Window, Cint, Cint, Cint, Cint)))
end

macro charfun(cb)
	:(cfunction($cb, Void, (Window, Cuint)))
end

macro monitorfun(cb)
	:(cfunction($cb, Void, (Monitor, Cint)))
end

immutable Vidmode
	width::Cint
	height::Cint
	redBits::Cint
	greenBits::Cint
	blueBits::Cint
	refreshRate::Cint
end

immutable Gammaramp
	red::Ptr{Cushort}
	green::Ptr{Cushort}
	blue::Ptr{Cushort}
	size::Cuint
end

function Init()
	return ccall((:glfwInit, "libglfw3"), Cint, ())
end

function Terminate()
	ccall((:glfwTerminate, "libglfw3"), Void, ())
end

function GetVersion()
	major = Cint[0]
	minor = Cint[0]
	rev = Cint[0]
	ccall((:glfwGetVersion, "libglfw3"), Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), major, minor, rev)
	return (major, minor, rev)
end

function SetErrorCallback(cbfun::Function)
	return ccall((:glfwSetErrorCallback, "libglfw3"), Ptr{Void}, (Ptr{Void},), @errorfun(cbfun))
end

function GetMonitors()
	count = Cint[0]
	r = ccall((:glfwGetMonitors, "libglfw3"), Ptr{Monitor}, (Ptr{Cint},), count)
	return (count)
end

function GetPrimaryMonitor()
	return ccall((:glfwGetPrimaryMonitor, "libglfw3"), Monitor, ())
end

function GetMonitorPos(monitor::Monitor)
	xpos = Cint[0]
	ypos = Cint[0]
	ccall((:glfwGetMonitorPos, "libglfw3"), Void, (Monitor, Ptr{Cint}, Ptr{Cint}), monitor, xpos, ypos)
	return (xpos, ypos)
end

function GetMonitorPhysicalSize(monitor::Monitor)
	width = Cint[0]
	height = Cint[0]
	ccall((:glfwGetMonitorPhysicalSize, "libglfw3"), Void, (Monitor, Ptr{Cint}, Ptr{Cint}), monitor, width, height)
	return (width, height)
end

function SetMonitorCallback(cbfun::Function)
	return ccall((:glfwSetMonitorCallback, "libglfw3"), Ptr{Void}, (Ptr{Void},), @monitorfun(cbfun))
end

function SetGamma(monitor::Monitor, gamma::FloatingPoint)
	ccall((:glfwSetGamma, "libglfw3"), Void, (Monitor, Cfloat), monitor, gamma)
end

function SetGammaRamp(monitor::Monitor, ramp::Gammaramp)
	ccall((:glfwSetGammaRamp, "libglfw3"), Void, (Monitor, Ptr{Void}), monitor, &ramp)
end

function DefaultWindowHints()
	ccall((:glfwDefaultWindowHints, "libglfw3"), Void, ())
end

function WindowHint(target::Integer, hint::Integer)
	ccall((:glfwWindowHint, "libglfw3"), Void, (Cint, Cint), target, hint)
end

function CreateWindow(width::Integer, height::Integer, title::String, monitor::Monitor, share::Window)
	return ccall((:glfwCreateWindow, "libglfw3"), Window, (Cint, Cint, Ptr{Cuchar}, Monitor, Window), width, height, bytestring(title), monitor, share)
end

function DestroyWindow(window::Window)
	ccall((:glfwDestroyWindow, "libglfw3"), Void, (Window,), window)
end

function WindowShouldClose(window::Window)
	return ccall((:glfwWindowShouldClose, "libglfw3"), Cint, (Window,), window)
end

function SetWindowShouldClose(window::Window, value::Integer)
	ccall((:glfwSetWindowShouldClose, "libglfw3"), Void, (Window, Cint), window, value)
end

function SetWindowTitle(window::Window, title::String)
	ccall((:glfwSetWindowTitle, "libglfw3"), Void, (Window, Ptr{Cuchar}), window, bytestring(title))
end

function GetWindowPos(window::Window)
	xpos = Cint[0]
	ypos = Cint[0]
	ccall((:glfwGetWindowPos, "libglfw3"), Void, (Window, Ptr{Cint}, Ptr{Cint}), window, xpos, ypos)
	return (xpos, ypos)
end

function SetWindowPos(window::Window, xpos::Integer, ypos::Integer)
	ccall((:glfwSetWindowPos, "libglfw3"), Void, (Window, Cint, Cint), window, xpos, ypos)
end

function GetWindowSize(window::Window)
	width = Cint[0]
	height = Cint[0]
	ccall((:glfwGetWindowSize, "libglfw3"), Void, (Window, Ptr{Cint}, Ptr{Cint}), window, width, height)
	return (width, height)
end

function SetWindowSize(window::Window, width::Integer, height::Integer)
	ccall((:glfwSetWindowSize, "libglfw3"), Void, (Window, Cint, Cint), window, width, height)
end

function GetFramebufferSize(window::Window)
	width = Cint[0]
	height = Cint[0]
	ccall((:glfwGetFramebufferSize, "libglfw3"), Void, (Window, Ptr{Cint}, Ptr{Cint}), window, width, height)
	return (width, height)
end

function IconifyWindow(window::Window)
	ccall((:glfwIconifyWindow, "libglfw3"), Void, (Window,), window)
end

function RestoreWindow(window::Window)
	ccall((:glfwRestoreWindow, "libglfw3"), Void, (Window,), window)
end

function ShowWindow(window::Window)
	ccall((:glfwShowWindow, "libglfw3"), Void, (Window,), window)
end

function HideWindow(window::Window)
	ccall((:glfwHideWindow, "libglfw3"), Void, (Window,), window)
end

function GetWindowMonitor(window::Window)
	return ccall((:glfwGetWindowMonitor, "libglfw3"), Monitor, (Window,), window)
end

function GetWindowAttrib(window::Window, attrib::Integer)
	return ccall((:glfwGetWindowAttrib, "libglfw3"), Cint, (Window, Cint), window, attrib)
end

function SetWindowUserPointer(window::Window, pointer::Ptr{Void})
	ccall((:glfwSetWindowUserPointer, "libglfw3"), Void, (Window, Ptr{Void}), window, pointer)
end

function GetWindowUserPointer(window::Window)
	return ccall((:glfwGetWindowUserPointer, "libglfw3"), Ptr{Void}, (Window,), window)
end

function SetWindowPosCallback(window::Window, cbfun::Function)
	return ccall((:glfwSetWindowPosCallback, "libglfw3"), Ptr{Void}, (Window, Ptr{Void}), window, @windowposfun(cbfun))
end

function SetWindowSizeCallback(window::Window, cbfun::Function)
	return ccall((:glfwSetWindowSizeCallback, "libglfw3"), Ptr{Void}, (Window, Ptr{Void}), window, @windowsizefun(cbfun))
end

function SetWindowCloseCallback(window::Window, cbfun::Function)
	return ccall((:glfwSetWindowCloseCallback, "libglfw3"), Ptr{Void}, (Window, Ptr{Void}), window, @windowclosefun(cbfun))
end

function SetWindowRefreshCallback(window::Window, cbfun::Function)
	return ccall((:glfwSetWindowRefreshCallback, "libglfw3"), Ptr{Void}, (Window, Ptr{Void}), window, @windowrefreshfun(cbfun))
end

function SetWindowFocusCallback(window::Window, cbfun::Function)
	return ccall((:glfwSetWindowFocusCallback, "libglfw3"), Ptr{Void}, (Window, Ptr{Void}), window, @windowfocusfun(cbfun))
end

function SetWindowIconifyCallback(window::Window, cbfun::Function)
	return ccall((:glfwSetWindowIconifyCallback, "libglfw3"), Ptr{Void}, (Window, Ptr{Void}), window, @windowiconifyfun(cbfun))
end

function SetFramebufferSizeCallback(window::Window, cbfun::Function)
	return ccall((:glfwSetFramebufferSizeCallback, "libglfw3"), Ptr{Void}, (Window, Ptr{Void}), window, @framebuffersizefun(cbfun))
end

function PollEvents()
	ccall((:glfwPollEvents, "libglfw3"), Void, ())
end

function WaitEvents()
	ccall((:glfwWaitEvents, "libglfw3"), Void, ())
end

function GetInputMode(window::Window, mode::Integer)
	return ccall((:glfwGetInputMode, "libglfw3"), Cint, (Window, Cint), window, mode)
end

function SetInputMode(window::Window, mode::Integer, value::Integer)
	ccall((:glfwSetInputMode, "libglfw3"), Void, (Window, Cint, Cint), window, mode, value)
end

function GetKey(window::Window, key::Integer)
	return ccall((:glfwGetKey, "libglfw3"), Cint, (Window, Cint), window, key)
end

function GetMouseButton(window::Window, button::Integer)
	return ccall((:glfwGetMouseButton, "libglfw3"), Cint, (Window, Cint), window, button)
end

function GetCursorPos(window::Window)
	xpos = Cdouble[0]
	ypos = Cdouble[0]
	ccall((:glfwGetCursorPos, "libglfw3"), Void, (Window, Ptr{Cdouble}, Ptr{Cdouble}), window, xpos, ypos)
	return (xpos, ypos)
end

function SetCursorPos(window::Window, xpos::FloatingPoint, ypos::FloatingPoint)
	ccall((:glfwSetCursorPos, "libglfw3"), Void, (Window, Cdouble, Cdouble), window, xpos, ypos)
end

function SetKeyCallback(window::Window, cbfun::Function)
	return ccall((:glfwSetKeyCallback, "libglfw3"), Ptr{Void}, (Window, Ptr{Void}), window, @keyfun(cbfun))
end

function SetCharCallback(window::Window, cbfun::Function)
	return ccall((:glfwSetCharCallback, "libglfw3"), Ptr{Void}, (Window, Ptr{Void}), window, @charfun(cbfun))
end

function SetMouseButtonCallback(window::Window, cbfun::Function)
	return ccall((:glfwSetMouseButtonCallback, "libglfw3"), Ptr{Void}, (Window, Ptr{Void}), window, @mousebuttonfun(cbfun))
end

function SetCursorPosCallback(window::Window, cbfun::Function)
	return ccall((:glfwSetCursorPosCallback, "libglfw3"), Ptr{Void}, (Window, Ptr{Void}), window, @cursorposfun(cbfun))
end

function SetCursorEnterCallback(window::Window, cbfun::Function)
	return ccall((:glfwSetCursorEnterCallback, "libglfw3"), Ptr{Void}, (Window, Ptr{Void}), window, @cursorenterfun(cbfun))
end

function SetScrollCallback(window::Window, cbfun::Function)
	return ccall((:glfwSetScrollCallback, "libglfw3"), Ptr{Void}, (Window, Ptr{Void}), window, @scrollfun(cbfun))
end

function JoystickPresent(joy::Integer)
	return ccall((:glfwJoystickPresent, "libglfw3"), Cint, (Cint,), joy)
end

function SetClipboardString(window::Window, string::String)
	ccall((:glfwSetClipboardString, "libglfw3"), Void, (Window, Ptr{Cuchar}), window, bytestring(string))
end

function GetTime()
	return ccall((:glfwGetTime, "libglfw3"), Cdouble, ())
end

function SetTime(time::FloatingPoint)
	ccall((:glfwSetTime, "libglfw3"), Void, (Cdouble,), time)
end

function MakeContextCurrent(window::Window)
	ccall((:glfwMakeContextCurrent, "libglfw3"), Void, (Window,), window)
end

function GetCurrentContext()
	return ccall((:glfwGetCurrentContext, "libglfw3"), Window, ())
end

function SwapBuffers(window::Window)
	ccall((:glfwSwapBuffers, "libglfw3"), Void, (Window,), window)
end

function SwapInterval(interval::Integer)
	ccall((:glfwSwapInterval, "libglfw3"), Void, (Cint,), interval)
end

function ExtensionSupported(extension::String)
	return ccall((:glfwExtensionSupported, "libglfw3"), Cint, (Ptr{Cuchar},), bytestring(extension))
end

function GetProcAddress(procname::String)
	return ccall((:glfwGetProcAddress, "libglfw3"), GLFWglproc, (Ptr{Cuchar},), bytestring(procname))
end

end # module
