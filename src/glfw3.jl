#************************************************************************
# Global definitions
#************************************************************************

# Key and button actions
@enum Action::Cint begin
	RELEASE                = 0
	PRESS                  = 1
	REPEAT                 = 2
end

@enum Key::Cint begin
	# Unknown key
	KEY_UNKNOWN            = -1

	# Printable keys
	KEY_SPACE              = 32
	KEY_APOSTROPHE         = 39  # '
	KEY_COMMA              = 44  # ,
	KEY_MINUS              = 45  # -
	KEY_PERIOD             = 46  # .
	KEY_SLASH              = 47  # /
	KEY_0                  = 48
	KEY_1                  = 49
	KEY_2                  = 50
	KEY_3                  = 51
	KEY_4                  = 52
	KEY_5                  = 53
	KEY_6                  = 54
	KEY_7                  = 55
	KEY_8                  = 56
	KEY_9                  = 57
	KEY_SEMICOLON          = 59  # ;
	KEY_EQUAL              = 61  # =
	KEY_A                  = 65
	KEY_B                  = 66
	KEY_C                  = 67
	KEY_D                  = 68
	KEY_E                  = 69
	KEY_F                  = 70
	KEY_G                  = 71
	KEY_H                  = 72
	KEY_I                  = 73
	KEY_J                  = 74
	KEY_K                  = 75
	KEY_L                  = 76
	KEY_M                  = 77
	KEY_N                  = 78
	KEY_O                  = 79
	KEY_P                  = 80
	KEY_Q                  = 81
	KEY_R                  = 82
	KEY_S                  = 83
	KEY_T                  = 84
	KEY_U                  = 85
	KEY_V                  = 86
	KEY_W                  = 87
	KEY_X                  = 88
	KEY_Y                  = 89
	KEY_Z                  = 90
	KEY_LEFT_BRACKET       = 91  # [
	KEY_BACKSLASH          = 92  # \
	KEY_RIGHT_BRACKET      = 93  # ]
	KEY_GRAVE_ACCENT       = 96  # `
	KEY_WORLD_1            = 161 # non-US #1
	KEY_WORLD_2            = 162 # non-US #2

	# Function keys
	KEY_ESCAPE             = 256
	KEY_ENTER              = 257
	KEY_TAB                = 258
	KEY_BACKSPACE          = 259
	KEY_INSERT             = 260
	KEY_DELETE             = 261
	KEY_RIGHT              = 262
	KEY_LEFT               = 263
	KEY_DOWN               = 264
	KEY_UP                 = 265
	KEY_PAGE_UP            = 266
	KEY_PAGE_DOWN          = 267
	KEY_HOME               = 268
	KEY_END                = 269
	KEY_CAPS_LOCK          = 280
	KEY_SCROLL_LOCK        = 281
	KEY_NUM_LOCK           = 282
	KEY_PRINT_SCREEN       = 283
	KEY_PAUSE              = 284
	KEY_F1                 = 290
	KEY_F2                 = 291
	KEY_F3                 = 292
	KEY_F4                 = 293
	KEY_F5                 = 294
	KEY_F6                 = 295
	KEY_F7                 = 296
	KEY_F8                 = 297
	KEY_F9                 = 298
	KEY_F10                = 299
	KEY_F11                = 300
	KEY_F12                = 301
	KEY_F13                = 302
	KEY_F14                = 303
	KEY_F15                = 304
	KEY_F16                = 305
	KEY_F17                = 306
	KEY_F18                = 307
	KEY_F19                = 308
	KEY_F20                = 309
	KEY_F21                = 310
	KEY_F22                = 311
	KEY_F23                = 312
	KEY_F24                = 313
	KEY_F25                = 314
	KEY_KP_0               = 320
	KEY_KP_1               = 321
	KEY_KP_2               = 322
	KEY_KP_3               = 323
	KEY_KP_4               = 324
	KEY_KP_5               = 325
	KEY_KP_6               = 326
	KEY_KP_7               = 327
	KEY_KP_8               = 328
	KEY_KP_9               = 329
	KEY_KP_DECIMAL         = 330
	KEY_KP_DIVIDE          = 331
	KEY_KP_MULTIPLY        = 332
	KEY_KP_SUBTRACT        = 333
	KEY_KP_ADD             = 334
	KEY_KP_ENTER           = 335
	KEY_KP_EQUAL           = 336
	KEY_LEFT_SHIFT         = 340
	KEY_LEFT_CONTROL       = 341
	KEY_LEFT_ALT           = 342
	KEY_LEFT_SUPER         = 343
	KEY_RIGHT_SHIFT        = 344
	KEY_RIGHT_CONTROL      = 345
	KEY_RIGHT_ALT          = 346
	KEY_RIGHT_SUPER        = 347
	KEY_MENU               = 348
end

# Modifier key bit flags
const MOD_SHIFT              = 0x0001
const MOD_CONTROL            = 0x0002
const MOD_ALT                = 0x0004
const MOD_SUPER              = 0x0008

# Mouse buttons
@enum MouseButton::Cint begin
	MOUSE_BUTTON_1         = 0
	MOUSE_BUTTON_2         = 1
	MOUSE_BUTTON_3         = 2
	MOUSE_BUTTON_4         = 3
	MOUSE_BUTTON_5         = 4
	MOUSE_BUTTON_6         = 5
	MOUSE_BUTTON_7         = 6
	MOUSE_BUTTON_8         = 7
end

const MOUSE_BUTTON_LEFT      = MOUSE_BUTTON_1
const MOUSE_BUTTON_RIGHT     = MOUSE_BUTTON_2
const MOUSE_BUTTON_MIDDLE    = MOUSE_BUTTON_3

# Joysticks
@enum Joystick::Cint begin
	JOYSTICK_1             = 0
	JOYSTICK_2             = 1
	JOYSTICK_3             = 2
	JOYSTICK_4             = 3
	JOYSTICK_5             = 4
	JOYSTICK_6             = 5
	JOYSTICK_7             = 6
	JOYSTICK_8             = 7
	JOYSTICK_9             = 8
	JOYSTICK_10            = 9
	JOYSTICK_11            = 10
	JOYSTICK_12            = 11
	JOYSTICK_13            = 12
	JOYSTICK_14            = 13
	JOYSTICK_15            = 14
	JOYSTICK_16            = 15
end

# Error codes
@enum ErrorCode::Cint begin
	NOT_INITIALIZED        = 0x00010001  # GLFW has not been initialized.
	NO_CURRENT_CONTEXT     = 0x00010002  # No context is current for this thread.
	INVALID_ENUM           = 0x00010003  # One of the arguments to the function was an invalid enum value.
	INVALID_VALUE          = 0x00010004  # One of the arguments to the function was an invalid value.
	OUT_OF_MEMORY          = 0x00010005  # A memory allocation failed.
	API_UNAVAILABLE        = 0x00010006  # GLFW could not find support for the requested API on the system.
	VERSION_UNAVAILABLE    = 0x00010007  # The requested OpenGL or OpenGL ES version is not available.
	PLATFORM_ERROR         = 0x00010008  # A platform-specific error occurred that does not match any of the more specific categories.
	FORMAT_UNAVAILABLE     = 0x00010009  # The requested format is not supported or available.
	NO_WINDOW_CONTEXT      = 0x0001000A  # The specified window does not have an OpenGL or OpenGL ES context.
end

const FOCUSED                 = 0x00020001
const ICONIFIED               = 0x00020002
const RESIZABLE               = 0x00020003
const VISIBLE                 = 0x00020004
const DECORATED               = 0x00020005
const AUTO_ICONIFY            = 0x00020006
const FLOATING                = 0x00020007
const MAXIMIZED               = 0x00020008
const CENTER_CURSOR           = 0x00020009
const TRANSPARENT_FRAMEBUFFER = 0x0002000A
const HOVERED                 = 0x0002000B
const FOCUS_ON_SHOW           = 0x0002000C

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
const CONTEXT_NO_ERROR       = 0x0002200A
const CONTEXT_CREATION_API   = 0x0002200B

const SCALE_TO_MONITOR       = 0x0002200C

const OPENGL_API             = 0x00030001
const OPENGL_ES_API          = 0x00030002
const NO_API                 =          0

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

const NATIVE_CONTEXT_API     = 0x00036001
const EGL_CONTEXT_API        = 0x00036002

# Standard cursor shapes
@enum StandardCursorShape::Cint begin
	ARROW_CURSOR           = 0x00036001
	IBEAM_CURSOR           = 0x00036002
	CROSSHAIR_CURSOR       = 0x00036003
	HAND_CURSOR            = 0x00036004
	HRESIZE_CURSOR         = 0x00036005
	VRESIZE_CURSOR         = 0x00036006
end

@enum DeviceConfigEvent::Cint begin
	CONNECTED              = 0x00040001
	DISCONNECTED           = 0x00040002
end

const DONT_CARE              = -1

#************************************************************************
# GLFW API types
#************************************************************************

struct Monitor
	handle::Ptr{Cvoid}
end
Base.show(io::IO, m::Monitor) = write(io, m.handle != C_NULL ? "$(m.name) Monitor ($(m.videomode))" : "No Monitor")

mutable struct Window
	handle::Ptr{Cvoid}
end

#Came from GLWindow.jl/screen.jl
"""
Function to create a pure GLFW OpenGL window
"""
function Window(
		;name = "GLWindow",
		resolution = standard_screen_resolution(),
		debugging = false,
		major = 3,
		minor = 3,# this is what GLVisualize needs to offer all features
		windowhints = standard_window_hints(),
		contexthints = standard_context_hints(major, minor),
		visible = true,
		focus = false,
		fullscreen = false,
		monitor = nothing,
		share = Window(C_NULL)
	)
	WindowHint(VISIBLE, visible)
	WindowHint(FOCUSED, focus)
	for ch in contexthints
		WindowHint(ch[1], ch[2])
	end
	for wh in windowhints
		WindowHint(wh[1], wh[2])
	end

	@static if Sys.isapple()
		if debugging
			@warn "OpenGL debug message callback is not available in macOS"
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

	window = CreateWindow(resolution..., String(name), Monitor(C_NULL), share)

	if fullscreen
		SetKeyCallback(window, (_1, button, _2, _3, _4) -> begin
			button == KEY_ESCAPE && make_windowed!(window)
		end)
		make_fullscreen!(window, monitor)
	end
	MakeContextCurrent(window)
	window
end

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
Base.show(io::IO, vm::VidMode) = write(io, "$(vm.width)x$(vm.height)@$(vm.refreshrate)Hz")

struct GLFWImage
	width::Cint
	height::Cint
	pixels::Ptr{UInt8}
end

function Base.cconvert(::Type{Ref{GLFWImage}}, image::AbstractMatrix{NTuple{4,UInt8}})
	imaget = permutedims(image) # c libglfw expects row major matrix
	return Base.RefValue{GLFWImage}(GLFWImage(size(imaget)..., pointer(imaget)))
end

function Base.cconvert(::Type{Ref{GLFWImage}}, images::Vector{<:AbstractMatrix{NTuple{4,UInt8}}})
	imagest = permutedims.(images)
	out = Vector{GLFWImage}(undef, length(imagest))
	@inbounds for i in 1:length(imagest)
		out[i] = GLFWImage(size(imagest[i])..., pointer(imagest[i]))
	end
	return (out, imagest)
end

function Base.unsafe_convert(::Type{Ref{GLFWImage}}, data::Tuple{Vector{GLFWImage},Vector{<:AbstractMatrix{NTuple{4,UInt8}}}})
	Base.unsafe_convert(Ref{GLFWImage}, data[1])
end

struct GLFWError <: Exception
	code::Union{ErrorCode, Integer}
	description::String

	GLFWError(code::ErrorCode, desc) = new(code, desc)
	GLFWError(code::Integer, desc) = new(try ErrorCode(code) catch; code end, desc)
end
Base.showerror(io::IO, e::GLFWError) = print(io, "GLFWError ($(e.code)): ", e.description)

#************************************************************************
# GLFW API functions
#************************************************************************

const INITIALIZED = Ref(false)

is_initialized() = INITIALIZED[]

# Initialization and version information
function Init()
	INITIALIZED[] = Bool(ccall((:glfwInit, libglfw), Cint, ())) || error("glfwInit failed")
end

function Terminate()
	INITIALIZED[] = false
	ccall((:glfwTerminate, libglfw), Cvoid, ())
end

GetVersionString() = unsafe_string(ccall((:glfwGetVersionString, libglfw), Cstring, ()))

# Error handling
@callback Error(code::Cint, description::Cstring) -> (GLFWError(code, unsafe_string(description)),)

# Monitor handling
function GetMonitors()
	count = Ref{Cint}()
	ptr = ccall((:glfwGetMonitors, libglfw), Ptr{Monitor}, (Ref{Cint},), count)
	unsafe_wrap(Array, ptr, count[])
end

GetPrimaryMonitor() = ccall((:glfwGetPrimaryMonitor, libglfw), Monitor, ())

function GetMonitorPos(monitor::Monitor)
	x, y = Ref{Cint}(), Ref{Cint}()
	ccall((:glfwGetMonitorPos, libglfw), Cvoid, (Monitor, Ref{Cint}, Ref{Cint}), monitor, x, y)
	(x=x[], y=y[])
end

function GetMonitorPhysicalSize(monitor::Monitor)
	width, height = Ref{Cint}(), Ref{Cint}()
	ccall((:glfwGetMonitorPhysicalSize, libglfw), Cvoid, (Monitor, Ref{Cint}, Ref{Cint}), monitor, width, height)
	(width=width[], height=height[])
end

function GetMonitorContentScale(monitor::Monitor)
	xscale, yscale = Ref{Cfloat}(), Ref{Cfloat}()
	ccall((:glfwGetMonitorContentScale, libglfw), Cvoid, (Monitor, Ref{Cfloat}, Ref{Cfloat}), monitor, xscale, yscale)
	(xscale=xscale[], yscale=yscale[])
end

GetMonitorName(monitor::Monitor) = unsafe_string(ccall((:glfwGetMonitorName, libglfw), Cstring, (Monitor,), monitor))
@callback Monitor(monitor::Monitor, event::DeviceConfigEvent)

function GetVideoModes(monitor::Monitor)
	count = Ref{Cint}()
	ptr = ccall((:glfwGetVideoModes, libglfw), Ptr{VidMode}, (Monitor, Ref{Cint}), monitor, count)
	unsafe_wrap(Array, ptr, count[])
end

GetVideoMode(monitor::Monitor) = unsafe_load(ccall((:glfwGetVideoMode, libglfw), Ptr{VidMode}, (Monitor,), monitor))
SetGamma(monitor::Monitor, gamma::Real) = ccall((:glfwSetGamma, libglfw), Cvoid, (Monitor, Cfloat), monitor, gamma)

# Window handling
DefaultWindowHints() = ccall((:glfwDefaultWindowHints, libglfw), Cvoid, ())
WindowHint(target::Integer, hint::Integer) = ccall((:glfwWindowHint, libglfw), Cvoid, (Cint, Cint), target, hint)

# Pair window handles with a callback function list
# to prevent them from being garbage-collected
const _window_callbacks = Dict{Window, Ref{Vector{Callback}}}()

function CreateWindow(width::Integer, height::Integer, title::AbstractString, monitor::Monitor=Monitor(C_NULL), share::Window=Window(C_NULL))
	window = ccall((:glfwCreateWindow, libglfw), Window, (Cint, Cint, Cstring, Monitor, Window), width, height, title, monitor, share)
	callbacks = Ref{Vector{Callback}}(fill(nothing, _window_callback_num[]))
	_window_callbacks[window] = callbacks
	ccall((:glfwSetWindowUserPointer, libglfw), Cvoid, (Window, Ref{Vector{Callback}}), window, callbacks)
	window
end

callbacks(window) = ccall((:glfwGetWindowUserPointer, libglfw), Ref{Vector{Callback}}, (Window,), window)

function DestroyWindow(window::Window)
	ccall((:glfwDestroyWindow, libglfw), Cvoid, (Window,), window)
	delete!(_window_callbacks, window)
end

WindowShouldClose(window::Window) = ccall((:glfwWindowShouldClose, libglfw), Cint, (Window,), window) != 0
SetWindowShouldClose(window::Window, value::Bool) = ccall((:glfwSetWindowShouldClose, libglfw), Cvoid, (Window, Cint), window, value)
SetWindowTitle(window::Window, title::AbstractString) = ccall((:glfwSetWindowTitle, libglfw), Cvoid, (Window, Cstring), window, title)

"""
    GLFW.SetWindowIcon(window::Window, image::Matrix{NTuple{4, UInt8}})

	GLFW.SetWindowIcon(window::Window, images::Vector{<:AbstractMatrix{NTuple{4,UInt8}}})

Set the window icon, where a single image may be passed or a vector of images with different icon sizes.
The images must be of RGBA format. Before calling this function it might be necessary to reinterpret the image
as a matrix of element type NTuple{4, UInt8}  if the icons are loaded with type RGBA{N0f8}

# Examples
```julia-repl
using FileIO
icons = load.(["icon-16.png", "icon-32.png", "icon-128.png"])
buffs = reinterpret.(NTuple{4, UInt8}, icons)
GLFW.SetWindowIcon(win, buffs)
GLFW.PollEvents() # needs a poll events to become active
```
"""
SetWindowIcon

function SetWindowIcon(window::Window, images::Vector{<:AbstractMatrix{NTuple{4,UInt8}}})
	ccall((:glfwSetWindowIcon, libglfw), Cvoid, (Window, Cint, Ref{GLFWImage}), window, length(images), images)
end

function SetWindowIcon(window::Window, image::AbstractMatrix{NTuple{4,UInt8}})
	ccall((:glfwSetWindowIcon, libglfw), Cvoid, (Window, Cint, Ref{GLFWImage}), window, 1, image)
end

function GetWindowPos(window::Window)
	x, y = Ref{Cint}(), Ref{Cint}()
	ccall((:glfwGetWindowPos, libglfw), Cvoid, (Window, Ref{Cint}, Ref{Cint}), window, x, y)
	(x=x[], y=y[])
end

SetWindowPos(window::Window, x::Integer, y::Integer) = ccall((:glfwSetWindowPos, libglfw), Cvoid, (Window, Cint, Cint), window, x, y)

function GetWindowSize(window::Window)
	width, height = Ref{Cint}(), Ref{Cint}()
	ccall((:glfwGetWindowSize, libglfw), Cvoid, (Window, Ref{Cint}, Ref{Cint}), window, width, height)
	(width=width[], height=height[])
end

SetWindowSizeLimits(window, minwidth, minheight, maxwidth, maxheight) = ccall((:glfwSetWindowSizeLimits, libglfw),
	Cvoid, (Window, Cint, Cint, Cint, Cint), window, minwidth, minheight, maxwidth, maxheight)
SetWindowAspectRatio(window, numer, denom) = ccall((:glfwSetWindowAspectRatio, libglfw),
	Cvoid, (Window, Cint, Cint), window, numer, denom)
SetWindowAspectRatio(window, r::Rational) = SetWindowAspectRatio(window, r.num, r.den)
SetWindowSize(window::Window, width::Integer, height::Integer) = ccall((:glfwSetWindowSize, libglfw), Cvoid, (Window, Cint, Cint), window, width, height)

function GetFramebufferSize(window::Window)
	width, height = Ref{Cint}(), Ref{Cint}()
	ccall((:glfwGetFramebufferSize, libglfw), Cvoid, (Window, Ref{Cint}, Ref{Cint}), window, width, height)
	(width=width[], height=height[])
end

function GetWindowFrameSize(window::Window)
	left, top, right, bottom = Ref{Cint}(), Ref{Cint}(), Ref{Cint}(), Ref{Cint}()
	ccall((:glfwGetWindowFrameSize, libglfw), Cvoid, (Window, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}), window, left, top, right, bottom)
	(left=left[], top=top[], right=right[], bottom=bottom[])
end

function GetWindowContentScale(window::Window)
	xscale, yscale = Ref{Cfloat}(), Ref{Cfloat}()
	ccall((:glfwGetWindowContentScale, libglfw), Cvoid, (Window, Ref{Cfloat}, Ref{Cfloat}), window, xscale, yscale)
	(xscale=xscale[], yscale=yscale[])
end

GetWindowAttrib(window::Window, attrib::Integer) = ccall((:glfwGetWindowAttrib, libglfw), Cint, (Window, Cint), window, attrib)

function SetWindowAttrib(window::Window, attrib::Integer, value::Integer)
	ccall((:glfwSetWindowAttrib, libglfw), Cvoid, (Window, Cint, Cint), window, attrib, value)
end

function WindowHintString(hint::Integer, value::AbstractString)
	ccall((:glfwWindowHintString, libglfw), Cvoid, (Cint, Cstring), hint, value)
end

RequestWindowAttention(window::Window) = ccall((:glfwRequestWindowAttention, libglfw), Cvoid, (Window,), window)

GetWindowOpacity(window::Window) = ccall((:glfwGetWindowOpacity, libglfw), Cfloat, (Window,), window)
SetWindowOpacity(window::Window, opacity::AbstractFloat) = ccall((:glfwSetWindowOpacity, libglfw), Cvoid, (Window, Cfloat), window, opacity)


IconifyWindow(window::Window) = ccall((:glfwIconifyWindow, libglfw), Cvoid, (Window,), window)
RestoreWindow(window::Window) = ccall((:glfwRestoreWindow, libglfw), Cvoid, (Window,), window)
MaximizeWindow(window) = ccall((:glfwMaximizeWindow, libglfw), Cvoid, (Window,), window)
ShowWindow(window::Window) = ccall((:glfwShowWindow, libglfw), Cvoid, (Window,), window)
HideWindow(window::Window) = ccall((:glfwHideWindow, libglfw), Cvoid, (Window,), window)
GetWindowMonitor(window::Window) = ccall((:glfwGetWindowMonitor, libglfw), Monitor, (Window,), window)
# TODO: Add SetWindowMonitor variants:
# - Monitor with video mode
# - Nothing with size and position
SetWindowMonitor(window, monitor, xpos, ypos, width, height, refreshRate) = ccall((:glfwSetWindowMonitor, libglfw),
	Cvoid, (Window, Monitor, Cint, Cint, Cint, Cint, Cint), window, monitor, xpos, ypos, width, height, refreshRate)
@windowcallback WindowPos(window::Window, x::Cint, y::Cint)
@windowcallback WindowSize(window::Window, width::Cint, height::Cint)
@windowcallback WindowClose(window::Window)
@windowcallback WindowRefresh(window::Window)
@windowcallback WindowFocus(window::Window, focused::Cint) -> (window, Bool(focused))
@windowcallback WindowIconify(window::Window, iconified::Cint) -> (window, Bool(iconified))
@windowcallback FramebufferSize(window::Window, width::Cint, height::Cint)
@windowcallback WindowContentScale(window::Window, xscale::Cfloat, yscale::Cfloat)
@windowcallback WindowMaximize(window::Window, maximized::Cint) -> (window, Bool(maximized))
PollEvents() = ccall((:glfwPollEvents, libglfw), Cvoid, ())
WaitEvents() = ccall((:glfwWaitEvents, libglfw), Cvoid, ())
WaitEvents(timeout) = ccall((:glfwWaitEventsTimeout, libglfw), Cvoid, (Cdouble,), timeout)
PostEmptyEvent() = ccall((:glfwPostEmptyEvent, libglfw), Cvoid, ())

# Input handling
function GetInputMode(window::Window, mode::Integer)
	value = ccall((:glfwGetInputMode, libglfw), Cint, (Window, Cint), window, mode)
	if mode in (STICKY_KEYS, STICKY_MOUSE_BUTTONS)
		value = Bool(value)
	end
	value
end

SetInputMode(window::Window, mode::Integer, value::Integer) = ccall((:glfwSetInputMode, libglfw), Cvoid, (Window, Cint, Cint), window, mode, value)

function GetKeyName(key, scancode=0)
	ptr = ccall((:glfwGetKeyName, libglfw), Cstring, (Cint, Cint), key, scancode)
	if ptr != C_NULL
		unsafe_string(ptr)
	end
end

GetKey(window::Window, key) = Bool(ccall((:glfwGetKey, libglfw), Cint, (Window, Cint), window, key))
GetMouseButton(window::Window, button) = Bool(ccall((:glfwGetMouseButton, libglfw), Cint, (Window, Cint), window, button))

function GetCursorPos(window::Window)
	x, y = Ref{Cdouble}(), Ref{Cdouble}()
	ccall((:glfwGetCursorPos, libglfw), Cvoid, (Window, Ref{Cdouble}, Ref{Cdouble}), window, x, y)
	(x=x[], y=y[])
end

SetCursorPos(window::Window, x::Real, y::Real) = ccall((:glfwSetCursorPos, libglfw), Cvoid, (Window, Cdouble, Cdouble), window, x, y)
# TODO: Add glfwCreateCursor
CreateStandardCursor(shape::StandardCursorShape) = ccall((:glfwCreateStandardCursor, libglfw), Cursor, (Cint,), shape)
DestroyCursor(cursor::Cursor) = ccall((:glfwDestroyCursor, libglfw), Cvoid, (Cursor,), cursor)
SetCursor(window::Window, cursor::Cursor) = ccall((:glfwSetCursor, libglfw), Cvoid, (Window, Cursor), window, cursor)
SetCursor(window::Window, ::Nothing) = SetCursor(window, Cursor(C_NULL))
@windowcallback Key(window::Window, key::Key, scancode::Cint, action::Action, mods::Cint)
@windowcallback Char(window::Window, codepoint::Cuint) -> (window, convert(Char, codepoint))
@windowcallback CharMods(window::Window, codepoint::Cuint, mods::Cint) -> (window, convert(Char, codepoint), mods)
@windowcallback MouseButton(window::Window, button::MouseButton, action::Action, mods::Cint)
@windowcallback CursorPos(window::Window, x::Cdouble, y::Cdouble)
@windowcallback CursorEnter(window::Window, entered::Cint) -> (window, Bool(entered))
@windowcallback Scroll(window::Window, xoffset::Cdouble, yoffset::Cdouble)
@windowcallback Drop(window::Window, count::Cint, paths::Ptr{Cstring}) -> (window, map(unsafe_string, unsafe_wrap(Array, paths, count)))
JoystickPresent(joy::Joystick) = Bool(ccall((:glfwJoystickPresent, libglfw), Cint, (Cint,), joy))

function GetJoystickAxes(joy::Joystick)
	count = Ref{Cint}()
	ptr = ccall((:glfwGetJoystickAxes, libglfw), Ptr{Cfloat}, (Cint, Ref{Cint}), joy, count)
	if ptr != C_NULL
		unsafe_wrap(Array, ptr, count[])
	end
end

function GetJoystickButtons(joy::Joystick)
	count = Ref{Cint}()
	ptr = ccall((:glfwGetJoystickButtons, libglfw), Ptr{Cuchar}, (Cint, Ref{Cint}), joy, count)
	if ptr != C_NULL
		unsafe_wrap(Array, ptr, count[])
	end
end

function GetJoystickName(joy::Joystick)
	ptr = ccall((:glfwGetJoystickName, libglfw), Cstring, (Cint,), joy)
	if ptr != C_NULL
		unsafe_string(ptr)
	end
end

@callback Joystick(joy::Joystick, event::DeviceConfigEvent)

# Context handling
MakeContextCurrent(window::Window) = ccall((:glfwMakeContextCurrent, libglfw), Cvoid, (Window,), window)
GetCurrentContext() = Base.cconvert(Window, ccall((:glfwGetCurrentContext, libglfw), Window, ()))
SwapBuffers(window::Window) = ccall((:glfwSwapBuffers, libglfw), Cvoid, (Window,), window)
SwapInterval(interval::Integer) = ccall((:glfwSwapInterval, libglfw), Cvoid, (Cint,), interval)
ExtensionSupported(extension::AbstractString) = Bool(ccall((:glfwExtensionSupported, libglfw), Cint, (Cstring,), extension))
GetProcAddress(procname::AbstractString) = ccall((:glfwGetProcAddress, libglfw), Ptr{Cvoid}, (Cstring,), procname)

#came from GLWindow/core.jl
"""
Returns the monitor resolution of the primary monitor.
"""
function primarymonitorresolution()
	m = GetPrimaryMonitor().videomode
	(Int(m.width), Int(m.height))
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
