
#************************************************************************
# GLFW API functions
#************************************************************************

# Initialization and version information
Init() = Bool(ccall( (:glfwInit, lib), Cint, ())) || error("glfwInit failed")
Terminate() = ccall( (:glfwTerminate, lib), Void, ())
GetVersionString() = unsafe_string(ccall( (:glfwGetVersionString, lib), Cstring, ()))

# Error handling
@callback Error(code::Cint, description::Cstring) -> (code, unsafe_string(description))

# Monitor handling
function GetMonitors()
	count = Ref{Cint}()
	ptr = ccall( (:glfwGetMonitors, lib), Ptr{Monitor}, (Ref{Cint},), count)
	unsafe_wrap(Array, ptr, count[])
end

GetPrimaryMonitor() = ccall( (:glfwGetPrimaryMonitor, lib), Monitor, ())

function GetMonitorPos(monitor::Monitor)
	xpos, ypos = Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetMonitorPos, lib), Void, (Monitor, Ref{Cint}, Ref{Cint}), monitor, xpos, ypos)
	(xpos[], ypos[])
end

function GetMonitorPhysicalSize(monitor::Monitor)
	width, height = Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetMonitorPhysicalSize, lib), Void, (Monitor, Ref{Cint}, Ref{Cint}), monitor, width, height)
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
SetGamma(monitor::Monitor, gamma::Real) = ccall( (:glfwSetGamma, lib), Void, (Monitor, Cfloat), monitor, gamma)

# Window handling
DefaultWindowHints() = ccall( (:glfwDefaultWindowHints, lib), Void, ())
WindowHint(target::Integer, hint::Integer) = ccall( (:glfwWindowHint, lib), Void, (Cint, Cint), target, hint)

function CreateWindow(width::Integer, height::Integer, title::AbstractString, monitor::Monitor=Monitor(C_NULL), share::Window=Window(C_NULL))
	handle = ccall( (:glfwCreateWindow, lib), WindowHandle, (Cint, Cint, Cstring, Monitor, WindowHandle), width, height, title, monitor, share)
	window = Window(handle)
	ccall( (:glfwSetWindowUserPointer, lib), Void, (WindowHandle, Ref{Window}), window, window)
	window
end

DestroyWindow(window::Window) = (yield(); ccall( (:glfwDestroyWindow, lib), Void, (WindowHandle,), window))
WindowShouldClose(window::Window) = ccall( (:glfwWindowShouldClose, lib), Cint, (WindowHandle,), window) != 0
SetWindowShouldClose(window::Window, value::Bool) = ccall( (:glfwSetWindowShouldClose, lib), Void, (WindowHandle, Cint), window, value)
SetWindowTitle(window::Window, title::AbstractString) = ccall( (:glfwSetWindowTitle, lib), Void, (WindowHandle, Cstring), window, title)

function GetWindowPos(window::Window)
	xpos, ypos = Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetWindowPos, lib), Void, (WindowHandle, Ref{Cint}, Ref{Cint}), window, xpos, ypos)
	(xpos[], ypos[])
end

SetWindowPos(window::Window, xpos::Integer, ypos::Integer) = ccall( (:glfwSetWindowPos, lib), Void, (WindowHandle, Cint, Cint), window, xpos, ypos)

function GetWindowSize(window::Window)
	width, height = Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetWindowSize, lib), Void, (WindowHandle, Ref{Cint}, Ref{Cint}), window, width, height)
	(width[], height[])
end

SetWindowSize(window::Window, width::Integer, height::Integer) = ccall( (:glfwSetWindowSize, lib), Void, (WindowHandle, Cint, Cint), window, width, height)

function GetFramebufferSize(window::Window)
	width, height = Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetFramebufferSize, lib), Void, (WindowHandle, Ref{Cint}, Ref{Cint}), window, width, height)
	(width[], height[])
end

function GetWindowFrameSize(window::Window)
	left, top, right, bottom = Ref{Cint}(), Ref{Cint}(), Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetWindowFrameSize, lib), Void, (WindowHandle, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}), window, left, top, right, bottom)
	(left[], top[], right[], bottom[])
end

IconifyWindow(window::Window) = ccall( (:glfwIconifyWindow, lib), Void, (WindowHandle,), window)
RestoreWindow(window::Window) = ccall( (:glfwRestoreWindow, lib), Void, (WindowHandle,), window)
ShowWindow(window::Window) = ccall( (:glfwShowWindow, lib), Void, (WindowHandle,), window)
HideWindow(window::Window) = ccall( (:glfwHideWindow, lib), Void, (WindowHandle,), window)
GetWindowMonitor(window::Window) = ccall( (:glfwGetWindowMonitor, lib), Monitor, (WindowHandle,), window)
GetWindowAttrib(window::Window, attrib::Integer) = ccall( (:glfwGetWindowAttrib, lib), Cint, (WindowHandle, Cint), window, attrib)
@callback WindowPos(window::Window, xpos::Cint, ypos::Cint)
@callback WindowSize(window::Window, width::Cint, height::Cint)
@callback WindowClose(window::Window)
@callback WindowRefresh(window::Window)
@callback WindowFocus(window::Window, focused::Cint) -> (window, Bool(focused))
@callback WindowIconify(window::Window, iconified::Cint) -> (window, Bool(iconified))
@callback FramebufferSize(window::Window, width::Cint, height::Cint)
PollEvents() = ccall( (:glfwPollEvents, lib), Void, ())
WaitEvents() = ccall( (:glfwWaitEvents, lib), Void, ())
PostEmptyEvent() = ccall( (:glfwPostEmptyEvent, lib), Void, ())

# Input handling
function GetInputMode(window::Window, mode::Integer)
	value = ccall( (:glfwGetInputMode, lib), Cint, (WindowHandle, Cint), window, mode)
	if mode in (STICKY_KEYS, STICKY_MOUSE_BUTTONS)
		value = Bool(value)
	end
	value
end

SetInputMode(window::Window, mode::Integer, value::Integer) = ccall( (:glfwSetInputMode, lib), Void, (WindowHandle, Cint, Cint), window, mode, value)
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
	ccall( (:glfwGetCursorPos, lib), Void, (WindowHandle, Ref{Cdouble}, Ref{Cdouble}), window, xpos, ypos)
	(xpos[], ypos[])
end

SetCursorPos(window::Window, xpos::Real, ypos::Real) = ccall( (:glfwSetCursorPos, lib), Void, (WindowHandle, Cdouble, Cdouble), window, xpos, ypos)
CreateStandardCursor(shape::Integer) = ccall( (:glfwCreateStandardCursor, lib), Cursor, (Cint,), shape)
DestroyCursor(cursor::Cursor) = ccall( (:glfwDestroyCursor, lib), Void, (Cursor,), cursor)
SetCursor(window::Window, cursor::Cursor) = ccall( (:glfwSetCursor, lib), Void, (WindowHandle, Cursor), window, cursor)
SetCursor(window::Window, ::Void) = SetCursor(window, Cursor(C_NULL))
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
MakeContextCurrent(window::Window) = ccall( (:glfwMakeContextCurrent, lib), Void, (WindowHandle,), window)
GetCurrentContext() = Base.cconvert(Window, ccall( (:glfwGetCurrentContext, lib), WindowHandle, ()))
SwapBuffers(window::Window) = ccall( (:glfwSwapBuffers, lib), Void, (WindowHandle,), window)
SwapInterval(interval::Integer) = ccall( (:glfwSwapInterval, lib), Void, (Cint,), interval)
ExtensionSupported(extension::AbstractString) = Bool(ccall( (:glfwExtensionSupported, lib), Cint, (Cstring,), extension))
GetProcAddress(procname::AbstractString) = ccall((:glfwGetProcAddress, lib), Ptr{Void}, (Cstring,), procname)

function SetWindowMonitor(window::Window, monitor::Monitor, xpos, ypos, width, height, refreshRate)
    ccall((:glfwSetWindowMonitor, lib), Void, (WindowHandle, Monitor, Cint, Cint, Cint, Cint, Cint), window, monitor, xpos, ypos, width, height, refreshRate)
end
