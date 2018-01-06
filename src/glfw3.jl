#************************************************************************
# Global definitions
#************************************************************************

# Key and button actions
const RELEASE                = 0
const PRESS                  = 1
const REPEAT                 = 2

# Unknown key
const KEY_UNKNOWN            = -1

# Printable keys
const KEY_SPACE              = 32
const KEY_APOSTROPHE         = 39  # '
const KEY_COMMA              = 44  # ,
const KEY_MINUS              = 45  # -
const KEY_PERIOD             = 46  # .
const KEY_SLASH              = 47  # /
const KEY_0                  = 48
const KEY_1                  = 49
const KEY_2                  = 50
const KEY_3                  = 51
const KEY_4                  = 52
const KEY_5                  = 53
const KEY_6                  = 54
const KEY_7                  = 55
const KEY_8                  = 56
const KEY_9                  = 57
const KEY_SEMICOLON          = 59  # ;
const KEY_EQUAL              = 61  # =
const KEY_A                  = 65
const KEY_B                  = 66
const KEY_C                  = 67
const KEY_D                  = 68
const KEY_E                  = 69
const KEY_F                  = 70
const KEY_G                  = 71
const KEY_H                  = 72
const KEY_I                  = 73
const KEY_J                  = 74
const KEY_K                  = 75
const KEY_L                  = 76
const KEY_M                  = 77
const KEY_N                  = 78
const KEY_O                  = 79
const KEY_P                  = 80
const KEY_Q                  = 81
const KEY_R                  = 82
const KEY_S                  = 83
const KEY_T                  = 84
const KEY_U                  = 85
const KEY_V                  = 86
const KEY_W                  = 87
const KEY_X                  = 88
const KEY_Y                  = 89
const KEY_Z                  = 90
const KEY_LEFT_BRACKET       = 91  # [
const KEY_BACKSLASH          = 92  # \
const KEY_RIGHT_BRACKET      = 93  # ]
const KEY_GRAVE_ACCENT       = 96  # `
const KEY_WORLD_1            = 161 # non-US #1
const KEY_WORLD_2            = 162 # non-US #2

# Function keys
const KEY_ESCAPE             = 256
const KEY_ENTER              = 257
const KEY_TAB                = 258
const KEY_BACKSPACE          = 259
const KEY_INSERT             = 260
const KEY_DELETE             = 261
const KEY_RIGHT              = 262
const KEY_LEFT               = 263
const KEY_DOWN               = 264
const KEY_UP                 = 265
const KEY_PAGE_UP            = 266
const KEY_PAGE_DOWN          = 267
const KEY_HOME               = 268
const KEY_END                = 269
const KEY_CAPS_LOCK          = 280
const KEY_SCROLL_LOCK        = 281
const KEY_NUM_LOCK           = 282
const KEY_PRINT_SCREEN       = 283
const KEY_PAUSE              = 284
const KEY_F1                 = 290
const KEY_F2                 = 291
const KEY_F3                 = 292
const KEY_F4                 = 293
const KEY_F5                 = 294
const KEY_F6                 = 295
const KEY_F7                 = 296
const KEY_F8                 = 297
const KEY_F9                 = 298
const KEY_F10                = 299
const KEY_F11                = 300
const KEY_F12                = 301
const KEY_F13                = 302
const KEY_F14                = 303
const KEY_F15                = 304
const KEY_F16                = 305
const KEY_F17                = 306
const KEY_F18                = 307
const KEY_F19                = 308
const KEY_F20                = 309
const KEY_F21                = 310
const KEY_F22                = 311
const KEY_F23                = 312
const KEY_F24                = 313
const KEY_F25                = 314
const KEY_KP_0               = 320
const KEY_KP_1               = 321
const KEY_KP_2               = 322
const KEY_KP_3               = 323
const KEY_KP_4               = 324
const KEY_KP_5               = 325
const KEY_KP_6               = 326
const KEY_KP_7               = 327
const KEY_KP_8               = 328
const KEY_KP_9               = 329
const KEY_KP_DECIMAL         = 330
const KEY_KP_DIVIDE          = 331
const KEY_KP_MULTIPLY        = 332
const KEY_KP_SUBTRACT        = 333
const KEY_KP_ADD             = 334
const KEY_KP_ENTER           = 335
const KEY_KP_EQUAL           = 336
const KEY_LEFT_SHIFT         = 340
const KEY_LEFT_CONTROL       = 341
const KEY_LEFT_ALT           = 342
const KEY_LEFT_SUPER         = 343
const KEY_RIGHT_SHIFT        = 344
const KEY_RIGHT_CONTROL      = 345
const KEY_RIGHT_ALT          = 346
const KEY_RIGHT_SUPER        = 347
const KEY_MENU               = 348
const KEY_LAST               = KEY_MENU

# Modifier key bit flags
const MOD_SHIFT              = 0x0001
const MOD_CONTROL            = 0x0002
const MOD_ALT                = 0x0004
const MOD_SUPER              = 0x0008

# Mouse buttons
const MOUSE_BUTTON_1         = 0
const MOUSE_BUTTON_2         = 1
const MOUSE_BUTTON_3         = 2
const MOUSE_BUTTON_4         = 3
const MOUSE_BUTTON_5         = 4
const MOUSE_BUTTON_6         = 5
const MOUSE_BUTTON_7         = 6
const MOUSE_BUTTON_8         = 7
const MOUSE_BUTTON_LAST      = MOUSE_BUTTON_8
const MOUSE_BUTTON_LEFT      = MOUSE_BUTTON_1
const MOUSE_BUTTON_RIGHT     = MOUSE_BUTTON_2
const MOUSE_BUTTON_MIDDLE    = MOUSE_BUTTON_3

# Joysticks
const JOYSTICK_1             = 0
const JOYSTICK_2             = 1
const JOYSTICK_3             = 2
const JOYSTICK_4             = 3
const JOYSTICK_5             = 4
const JOYSTICK_6             = 5
const JOYSTICK_7             = 6
const JOYSTICK_8             = 7
const JOYSTICK_9             = 8
const JOYSTICK_10            = 9
const JOYSTICK_11            = 10
const JOYSTICK_12            = 11
const JOYSTICK_13            = 12
const JOYSTICK_14            = 13
const JOYSTICK_15            = 14
const JOYSTICK_16            = 15
const JOYSTICK_LAST          = JOYSTICK_16

# Error codes
@enum(ErrorCode,
	NOT_INITIALIZED        = 0x00010001,  # GLFW has not been initialized.
	NO_CURRENT_CONTEXT     = 0x00010002,  # No context is current for this thread.
	INVALID_ENUM           = 0x00010003,  # One of the arguments to the function was an invalid enum value.
	INVALID_VALUE          = 0x00010004,  # One of the arguments to the function was an invalid value.
	OUT_OF_MEMORY          = 0x00010005,  # A memory allocation failed.
	API_UNAVAILABLE        = 0x00010006,  # GLFW could not find support for the requested API on the system.
	VERSION_UNAVAILABLE    = 0x00010007,  # The requested OpenGL or OpenGL ES version is not available.
	PLATFORM_ERROR         = 0x00010008,  # A platform-specific error occurred that does not match any of the more specific categories.
	FORMAT_UNAVAILABLE     = 0x00010009,  # The requested format is not supported or available.
	NO_WINDOW_CONTEXT      = 0x0001000A   # The specified window does not have an OpenGL or OpenGL ES context.
)

const FOCUSED                = 0x00020001
const ICONIFIED              = 0x00020002
const RESIZABLE              = 0x00020003
const VISIBLE                = 0x00020004
const DECORATED              = 0x00020005
const AUTO_ICONIFY           = 0x00020006
const FLOATING               = 0x00020007

const RED_BITS               = 0x00021001
const GREEN_BITS             = 0x00021002
const BLUE_BITS              = 0x00021003
const ALPHA_BITS             = 0x00021004
const DEPTH_BITS             = 0x00021005
const STENCIL_BITS           = 0x00021006
const ACCUM_RED_BITS         = 0x00021007
const ACCUM_GREEN_BITS       = 0x00021008
const ACCUM_BLUE_BITS        = 0x00021009
const ACCUM_ALPHA_BITS       = 0x0002100A
const AUX_BUFFERS            = 0x0002100B
const STEREO                 = 0x0002100C
const SAMPLES                = 0x0002100D
const SRGB_CAPABLE           = 0x0002100E
const REFRESH_RATE           = 0x0002100F
const DOUBLEBUFFER           = 0x00021010

const CLIENT_API             = 0x00022001
const CONTEXT_VERSION_MAJOR  = 0x00022002
const CONTEXT_VERSION_MINOR  = 0x00022003
const CONTEXT_REVISION       = 0x00022004
const CONTEXT_ROBUSTNESS     = 0x00022005
const OPENGL_FORWARD_COMPAT  = 0x00022006
const OPENGL_DEBUG_CONTEXT   = 0x00022007
const OPENGL_PROFILE         = 0x00022008
const CONTEXT_RELEASE_BEHAVIOR = 0x00022009

const OPENGL_API             = 0x00030001
const OPENGL_ES_API          = 0x00030002

const NO_ROBUSTNESS          =          0
const NO_RESET_NOTIFICATION  = 0x00031001
const LOSE_CONTEXT_ON_RESET  = 0x00031002

const OPENGL_ANY_PROFILE     =          0
const OPENGL_CORE_PROFILE    = 0x00032001
const OPENGL_COMPAT_PROFILE  = 0x00032002

const CURSOR                 = 0x00033001
const STICKY_KEYS            = 0x00033002
const STICKY_MOUSE_BUTTONS   = 0x00033003

const CURSOR_NORMAL          = 0x00034001
const CURSOR_HIDDEN          = 0x00034002
const CURSOR_DISABLED        = 0x00034003

const ANY_RELEASE_BEHAVIOR   =          0
const RELEASE_BEHAVIOR_FLUSH = 0x00035001
const RELEASE_BEHAVIOR_NONE  = 0x00035002

# Standard cursor shapes
const ARROW_CURSOR           = 0x00036001
const IBEAM_CURSOR           = 0x00036002
const CROSSHAIR_CURSOR       = 0x00036003
const HAND_CURSOR            = 0x00036004
const HRESIZE_CURSOR         = 0x00036005
const VRESIZE_CURSOR         = 0x00036006

const CONNECTED              = 0x00040001
const DISCONNECTED           = 0x00040002

const DONT_CARE              = -1

#************************************************************************
# GLFW API types
#************************************************************************

struct Monitor
	handle::Ptr{Cvoid}
end
Base.show(io::IO, m::Monitor) = write(io, "Monitor($(m.handle == C_NULL ? m.handle : GetMonitorName(m)))")

const WindowHandle = Ptr{Cvoid}

mutable struct Window
	handle::WindowHandle
	callbacks::Vector{Function}
end
Window(handle::WindowHandle) = Window(handle, Vector{Function}(_window_callbacks_len[]))
#Came from GLWindow.jl/screen.jl
"""
Function to create a pure GLFW OpenGL window
"""
function Window(
        name = "GLWindow";
        resolution = standard_screen_resolution(),
        debugging = false,
        major = 3,
        minor = 3,# this is what GLVisualize needs to offer all features
        windowhints = standard_window_hints(),
        contexthints = standard_context_hints(major, minor),
        visible = true,
        focus = false,
        fullscreen = false,
        monitor = nothing
    )
    WindowHint(VISIBLE, visible)
    WindowHint(FOCUSED, focus)
    for ch in contexthints
        WindowHint(ch[1], ch[2])
    end
    for wh in windowhints
        WindowHint(wh[1], wh[2])
    end

    @static if is_apple()
        if debugging
            warn("OpenGL debug message callback not available on osx")
            debugging = false
        end
    end

    WindowHint(OPENGL_DEBUG_CONTEXT, Cint(debugging))

    monitor = if monitor == nothing
        GetPrimaryMonitor()
    elseif isa(monitor, Integer)
        GetMonitors()[monitor]
    elseif isa(monitor, Monitor)
        monitor
    else
        error("Monitor needs to be nothing, int, or GLFW.Monitor. Found: $monitor")
    end

    window = CreateWindow(resolution..., String(name))

    if fullscreen
        SetKeyCallback(window, (_1, button, _2, _3, _4) -> begin
            button == KEY_ESCAPE && make_windowed!(window)
        end)
        make_fullscreen!(window, monitor)
    end

    MakeContextCurrent(window)

    window
end

import Base.==; ==(x::Window, y::Window) = (x.handle == y.handle)
Base.cconvert(::Type{WindowHandle}, window::Window) = window.handle
Base.cconvert(::Type{Window}, handle::WindowHandle) = ccall( (:glfwGetWindowUserPointer, lib), Ref{Window}, (WindowHandle,), handle)
Base.hash(window::Window, h::UInt64) = hash(window.handle, h)

function make_windowed!(window::Window)
    width, height = standard_screen_resolution()
    SetWindowMonitor(window, Monitor(C_NULL), 0, 0, width, height, DONT_CARE)
    return
end

function make_fullscreen!(window::Window, monitor::Monitor = GetPrimaryMonitor())
    vidmodes = GetVideoModes(monitor)[end]
    SetWindowMonitor(window, monitor, 0, 0, vidmodes.width, vidmodes.height, GLFW.DONT_CARE)
    return
end

"""
Sets visibility of OpenGL window. Will still render if not visible.
Only applies to the root screen holding the opengl context.
"""
function set_visibility!(screen::Window, visible::Bool)
    if visible
        ShowWindow(screen)
    else !visible
        HideWindow(screen)
    end
    return
end

struct Cursor
	handle::Ptr{Cvoid}
end

struct VidMode
	width::Cint         # The width, in screen coordinates, of the video mode.
	height::Cint        # The height, in screen coordinates, of the video mode.
	redbits::Cint       # The bit depth of the red channel of the video mode.
	greenbits::Cint     # The bit depth of the green channel of the video mode.
	bluebits::Cint      # The bit depth of the blue channel of the video mode.
	refreshrate::Cint   # The refresh rate, in Hz, of the video mode.
end

struct GLFWError <: Exception
	code::Union{ErrorCode, Integer}
	description::String

	GLFWError(code::ErrorCode, desc) = new(code, desc)
	GLFWError(code::Integer, desc) = new(try ErrorCode(code) catch; code end, desc)
end
Base.showerror(io::IO, e::GLFWError) = print(io, "GLFWError ($(e.code)): ", e.description)

# From GLWindow.jl/types.jl
struct MonitorProperties
    name::String
    isprimary::Bool
    position::NTuple{2, Int}
    physicalsize::NTuple{2, Int}
    videomode::VidMode
    videomode_supported::Vector{VidMode}
    dpi::NTuple{2, Float64}
    monitor::Monitor
end

function MonitorProperties(monitor::Monitor)
    name = GetMonitorName(monitor)
    isprimary = GetPrimaryMonitor() == monitor
    position = GetMonitorPos(monitor)
    physicalsize = GetMonitorPhysicalSize(monitor)
    videomode = GetVideoMode(monitor)
    sfactor = is_apple() ? 2.0 : 1.0
    dpi = (videomode.width * 25.4, videomode.height * 25.4) * sfactor ./ physicalsize
    videomode_supported = GetVideoModes(monitor)

    MonitorProperties(name, isprimary, position, physicalsize, videomode, videomode_supported, dpi, monitor)
end

# From GLWindow.jl/core.jl
function Base.show(io::IO, m::MonitorProperties)
    println(io, "name: ", m.name)
    println(io, "physicalsize: ",  m.physicalsize[1], "x", m.physicalsize[2])
    println(io, "resolution: ", m.videomode.width, "x", m.videomode.height)
    println(io, "dpi: ", m.dpi[1], "x", m.dpi[2])
end

#************************************************************************
# GLFW API functions
#************************************************************************

# Initialization and version information
Init() = Bool(ccall( (:glfwInit, lib), Cint, ())) || error("glfwInit failed")
Terminate() = ccall( (:glfwTerminate, lib), Cvoid, ())
GetVersionString() = unsafe_string(ccall( (:glfwGetVersionString, lib), Cstring, ()))

# Error handling
@callback Error(code::Cint, description::Cstring) -> (GLFWError(code, unsafe_string(description)),)

# Monitor handling
function GetMonitors()
	count = Ref{Cint}()
	ptr = ccall( (:glfwGetMonitors, lib), Ptr{Monitor}, (Ref{Cint},), count)
	unsafe_wrap(Array, ptr, count[])
end

GetPrimaryMonitor() = ccall( (:glfwGetPrimaryMonitor, lib), Monitor, ())

function GetMonitorPos(monitor::Monitor)
	xpos, ypos = Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetMonitorPos, lib), Cvoid, (Monitor, Ref{Cint}, Ref{Cint}), monitor, xpos, ypos)
	(xpos[], ypos[])
end

function GetMonitorPhysicalSize(monitor::Monitor)
	width, height = Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetMonitorPhysicalSize, lib), Cvoid, (Monitor, Ref{Cint}, Ref{Cint}), monitor, width, height)
	(width[], height[])
end

GetMonitorName(monitor::Monitor) = unsafe_string(ccall( (:glfwGetMonitorName, lib), Cstring, (Monitor,), monitor))
@callback Monitor(monitor::Monitor, event::Cint)

function GetVideoModes(monitor::Monitor)
	count = Ref{Cint}()
	ptr = ccall( (:glfwGetVideoModes, lib), Ptr{VidMode}, (Monitor, Ref{Cint}), monitor, count)
	unsafe_wrap(Array, ptr, count[])
end

GetVideoMode(monitor::Monitor) = unsafe_load(ccall( (:glfwGetVideoMode, lib), Ptr{VidMode}, (Monitor,), monitor))
SetGamma(monitor::Monitor, gamma::Real) = ccall( (:glfwSetGamma, lib), Cvoid, (Monitor, Cfloat), monitor, gamma)

# Window handling
DefaultWindowHints() = ccall( (:glfwDefaultWindowHints, lib), Cvoid, ())
WindowHint(target::Integer, hint::Integer) = ccall( (:glfwWindowHint, lib), Cvoid, (Cint, Cint), target, hint)

function CreateWindow(width::Integer, height::Integer, title::AbstractString, monitor::Monitor=Monitor(C_NULL), share::Window=Window(C_NULL))
	handle = ccall( (:glfwCreateWindow, lib), WindowHandle, (Cint, Cint, Cstring, Monitor, WindowHandle), width, height, title, monitor, share)
	window = Window(handle)
	ccall( (:glfwSetWindowUserPointer, lib), Cvoid, (WindowHandle, Ref{Window}), window, window)
	window
end

DestroyWindow(window::Window) = (yield(); ccall( (:glfwDestroyWindow, lib), Cvoid, (WindowHandle,), window))
WindowShouldClose(window::Window) = ccall( (:glfwWindowShouldClose, lib), Cint, (WindowHandle,), window) != 0
SetWindowShouldClose(window::Window, value::Bool) = ccall( (:glfwSetWindowShouldClose, lib), Cvoid, (WindowHandle, Cint), window, value)
SetWindowTitle(window::Window, title::AbstractString) = ccall( (:glfwSetWindowTitle, lib), Cvoid, (WindowHandle, Cstring), window, title)

function GetWindowPos(window::Window)
	xpos, ypos = Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetWindowPos, lib), Cvoid, (WindowHandle, Ref{Cint}, Ref{Cint}), window, xpos, ypos)
	(xpos[], ypos[])
end

SetWindowPos(window::Window, xpos::Integer, ypos::Integer) = ccall( (:glfwSetWindowPos, lib), Cvoid, (WindowHandle, Cint, Cint), window, xpos, ypos)

function GetWindowSize(window::Window)
	width, height = Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetWindowSize, lib), Cvoid, (WindowHandle, Ref{Cint}, Ref{Cint}), window, width, height)
	(width[], height[])
end

SetWindowSize(window::Window, width::Integer, height::Integer) = ccall( (:glfwSetWindowSize, lib), Cvoid, (WindowHandle, Cint, Cint), window, width, height)

function GetFramebufferSize(window::Window)
	width, height = Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetFramebufferSize, lib), Cvoid, (WindowHandle, Ref{Cint}, Ref{Cint}), window, width, height)
	(width[], height[])
end

function GetWindowFrameSize(window::Window)
	left, top, right, bottom = Ref{Cint}(), Ref{Cint}(), Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetWindowFrameSize, lib), Cvoid, (WindowHandle, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}), window, left, top, right, bottom)
	(left[], top[], right[], bottom[])
end

IconifyWindow(window::Window) = ccall( (:glfwIconifyWindow, lib), Cvoid, (WindowHandle,), window)
RestoreWindow(window::Window) = ccall( (:glfwRestoreWindow, lib), Cvoid, (WindowHandle,), window)
ShowWindow(window::Window) = ccall( (:glfwShowWindow, lib), Cvoid, (WindowHandle,), window)
HideWindow(window::Window) = ccall( (:glfwHideWindow, lib), Cvoid, (WindowHandle,), window)
GetWindowMonitor(window::Window) = ccall( (:glfwGetWindowMonitor, lib), Monitor, (WindowHandle,), window)
GetWindowAttrib(window::Window, attrib::Integer) = ccall( (:glfwGetWindowAttrib, lib), Cint, (WindowHandle, Cint), window, attrib)
@callback WindowPos(window::Window, xpos::Cint, ypos::Cint)
@callback WindowSize(window::Window, width::Cint, height::Cint)
@callback WindowClose(window::Window)
@callback WindowRefresh(window::Window)
@callback WindowFocus(window::Window, focused::Cint) -> (window, Bool(focused))
@callback WindowIconify(window::Window, iconified::Cint) -> (window, Bool(iconified))
@callback FramebufferSize(window::Window, width::Cint, height::Cint)
PollEvents() = ccall( (:glfwPollEvents, lib), Cvoid, ())
WaitEvents() = ccall( (:glfwWaitEvents, lib), Cvoid, ())
PostEmptyEvent() = ccall( (:glfwPostEmptyEvent, lib), Cvoid, ())

# Input handling
function GetInputMode(window::Window, mode::Integer)
	value = ccall( (:glfwGetInputMode, lib), Cint, (WindowHandle, Cint), window, mode)
	if mode in (STICKY_KEYS, STICKY_MOUSE_BUTTONS)
		value = Bool(value)
	end
	value
end

SetInputMode(window::Window, mode::Integer, value::Integer) = ccall( (:glfwSetInputMode, lib), Cvoid, (WindowHandle, Cint, Cint), window, mode, value)
GetKey(window::Window, key::Integer) = Bool(ccall( (:glfwGetKey, lib), Cint, (WindowHandle, Cint), window, key))

function GetKeyName(key::Integer, scancode::Integer)
	ptr = ccall( (:glfwGetKeyName, lib), Cstring, (Cint, Cint), key, scancode)
	if ptr == C_NULL
		Nullable{String}()
	else
		Nullable(unsafe_string(ptr))
	end
end

GetMouseButton(window::Window, button::Integer) = Bool(ccall( (:glfwGetMouseButton, lib), Cint, (WindowHandle, Cint), window, button))

function GetCursorPos(window::Window)
	xpos, ypos = Ref{Cdouble}(), Ref{Cdouble}()
	ccall( (:glfwGetCursorPos, lib), Cvoid, (WindowHandle, Ref{Cdouble}, Ref{Cdouble}), window, xpos, ypos)
	(xpos[], ypos[])
end

SetCursorPos(window::Window, xpos::Real, ypos::Real) = ccall( (:glfwSetCursorPos, lib), Cvoid, (WindowHandle, Cdouble, Cdouble), window, xpos, ypos)
CreateStandardCursor(shape::Integer) = ccall( (:glfwCreateStandardCursor, lib), Cursor, (Cint,), shape)
DestroyCursor(cursor::Cursor) = ccall( (:glfwDestroyCursor, lib), Cvoid, (Cursor,), cursor)
SetCursor(window::Window, cursor::Cursor) = ccall( (:glfwSetCursor, lib), Cvoid, (WindowHandle, Cursor), window, cursor)
SetCursor(window::Window, ::Cvoid) = SetCursor(window, Cursor(C_NULL))
@callback Key(window::Window, key::Cint, scancode::Cint, action::Cint, mods::Cint)
@callback Char(window::Window, codepoint::Cuint) -> (window, convert(Char, codepoint))
@callback CharMods(window::Window, codepoint::Cuint, mods::Cint) -> (window, convert(Char, codepoint), mods)
@callback MouseButton(window::Window, button::Cint, action::Cint, mods::Cint)
@callback CursorPos(window::Window, xpos::Cdouble, ypos::Cdouble)
@callback CursorEnter(window::Window, entered::Cint) -> (window, Bool(entered))
@callback Scroll(window::Window, xoffset::Cdouble, yoffset::Cdouble)
@callback Drop(window::Window, count::Cint, paths::Ptr{Cstring}) -> (window, map(unsafe_string, unsafe_wrap(Array, paths, count)))
JoystickPresent(joy::Integer) = Bool(ccall( (:glfwJoystickPresent, lib), Cint, (Cint,), joy))

function GetJoystickAxes(joy::Integer)
	count = Ref{Cint}()
	ptr = ccall( (:glfwGetJoystickAxes, lib), Ptr{Cfloat}, (Cint, Ref{Cint}), joy, count)
	unsafe_wrap(Array, ptr, count[])
end

function GetJoystickButtons(joy::Integer)
	count = Ref{Cint}()
	ptr = ccall( (:glfwGetJoystickButtons, lib), Ptr{Cuchar}, (Cint, Ref{Cint}), joy, count)
	unsafe_wrap(Array, ptr, count[])
end

GetJoystickName(joy::Integer) = unsafe_string(ccall( (:glfwGetJoystickName, lib), Cstring, (Cint,), joy))

# Context handling
MakeContextCurrent(window::Window) = ccall( (:glfwMakeContextCurrent, lib), Cvoid, (WindowHandle,), window)
GetCurrentContext() = Base.cconvert(Window, ccall( (:glfwGetCurrentContext, lib), WindowHandle, ()))
SwapBuffers(window::Window) = ccall( (:glfwSwapBuffers, lib), Cvoid, (WindowHandle,), window)
SwapInterval(interval::Integer) = ccall( (:glfwSwapInterval, lib), Cvoid, (Cint,), interval)
ExtensionSupported(extension::AbstractString) = Bool(ccall( (:glfwExtensionSupported, lib), Cint, (Cstring,), extension))
GetProcAddress(procname::AbstractString) = ccall((:glfwGetProcAddress, lib), Ptr{Cvoid}, (Cstring,), procname)

function SetWindowMonitor(window::Window, monitor::Monitor, xpos, ypos, width, height, refreshRate)
    ccall((:glfwSetWindowMonitor, lib), Cvoid, (WindowHandle, Monitor, Cint, Cint, Cint, Cint, Cint), window, monitor, xpos, ypos, width, height, refreshRate)
end

#came from GLWindow/core.jl
"""
Returns the monitor resolution of the primary monitor.
"""
function primarymonitorresolution()
    props = MonitorProperties(GetPrimaryMonitor())
    w,h = props.videomode.width, props.videomode.height
    # Vec(Int(w),Int(h))
    (Int(w),Int(h))
end

#Came from GLWindow.jl/screen.jl

"""
Takes half the resolution of the primary monitor.
This should make for sensible defaults!
"""
function standard_screen_resolution()
    w, h = primarymonitorresolution()
    (div(w,2), div(h,2)) # half of total resolution seems like a good fit!
end


"""
Tries to create sensible context hints!
Taken from lessons learned at:
[GLFW](http://www.glfw.org/docs/latest/window.html)
"""
function standard_context_hints(major, minor)
    # this is spaar...Modern OpenGL !!!!
    major < 3 && error("OpenGL major needs to be at least 3.0. Given: $major")
    # core profile is only supported for OpenGL 3.2+ (and a must for OSX, so
    # for the sake of homogenity, we try to default to it for everyone!)
    if (major > 3 || (major == 3 && minor >= 2 ))
        profile = OPENGL_CORE_PROFILE
    else
        profile = OPENGL_ANY_PROFILE
    end
    [
        (CONTEXT_VERSION_MAJOR, major),
        (CONTEXT_VERSION_MINOR, minor),
        (OPENGL_FORWARD_COMPAT, Cint(1)),
        (OPENGL_PROFILE, profile)
    ]
end


"""
Standard window hints for creating a plain context without any multisampling
or extra buffers beside the color buffer
"""
function standard_window_hints()
    [
        (SAMPLES,      0),
        (DEPTH_BITS,   0),

        (ALPHA_BITS,   8),
        (RED_BITS,     8),
        (GREEN_BITS,   8),
        (BLUE_BITS,    8),

        (STENCIL_BITS, 0),
        (AUX_BUFFERS,  0)
    ]
end
