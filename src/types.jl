#************************************************************************
# GLFW API types
#************************************************************************

immutable Monitor
	handle::Ptr{Void}
end
Base.show(io::IO, m::Monitor) = write(io, "Monitor($(m.handle == C_NULL ? m.handle : GetMonitorName(m)))")

const WindowHandle = Ptr{Void}

type Window
	handle::WindowHandle
	callbacks::Vector{Function}
end
Window(handle::WindowHandle) = Window(handle, Vector{Function}(_window_callbacks_len[]))
#Came from GLWindow.jl/screen.jl
#TODO Shadercache?
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
    # we create a new context, so we need to clear the shader cache.
    # TODO, cache shaders in GLAbstraction per GL context
    WindowHint(VISIBLE, visible)
    WindowHint(FOCUSED, focus)
    # GLAbstraction.empty_shader_cache!()
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
    # tell GLAbstraction that we created a new context.
    # This is important for resource tracking
    # GLAbstraction.new_context()

    debugging && glDebugMessageCallbackARB(_openglerrorcallback, C_NULL)
    window
end


import Base.==; ==(x::Window, y::Window) = (x.handle == y.handle)
Base.cconvert(::Type{WindowHandle}, window::Window) = window.handle
Base.cconvert(::Type{Window}, handle::WindowHandle) = ccall( (:glfwGetWindowUserPointer, lib), Ref{Window}, (WindowHandle,), handle)
Base.hash(window::Window, h::UInt64) = hash(window.handle, h)
function Base.isopen(window::Window)
    window.handle == C_NULL && return false
    !WindowShouldClose(window)
end

function Base.resize!(x::Window, w::Integer, h::Integer)
    SetWindowSize(x, w, h)
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

function swapbuffers(window::Window)
    window.handle == C_NULL && return
    SwapBuffers(window)
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

immutable Cursor
	handle::Ptr{Void}
end

immutable VidMode
	width::Cint         # The width, in screen coordinates, of the video mode.
	height::Cint        # The height, in screen coordinates, of the video mode.
	redbits::Cint       # The bit depth of the red channel of the video mode.
	greenbits::Cint     # The bit depth of the green channel of the video mode.
	bluebits::Cint      # The bit depth of the blue channel of the video mode.
	refreshrate::Cint   # The refresh rate, in Hz, of the video mode.
end

immutable GLFWError <: Exception
	code::ErrorCode
	description::String
end
Base.showerror(io::IO, e::GLFWError) = print(io, "GLFWError ($(e.code)): ", e.description)

#Came from GLWindow.jl/types.jl
struct MonitorProperties 
    name::String
    isprimary::Bool
    position::Vector{Int}
    # position::Vec{2, Int}
    # physicalsize::Vec{2, Int}
    physicalsize::Vector{Int}
    videomode::VidMode
    videomode_supported::Vector{VidMode}
    # dpi::Vec{2, Float64}
    dpi::Vector{Float64}
    monitor::Monitor
end

function MonitorProperties(monitor::Monitor)
    name = GetMonitorName(monitor)
    isprimary = GetPrimaryMonitor() == monitor
    position = GetMonitorPos(monitor)
    physicalsize = Float64[GetMonitorPhysicalSize(monitor)]
    videomode = GetVideoMode(monitor)
    sfactor = is_apple() ? 2.0 : 1.0
    dpi = [videomode.width * 25.4, videomode.height * 25.4] * sfactor ./ physicalsize
    videomode_supported = GetVideoModes(monitor)

    MonitorProperties(name, isprimary, position, physicalsize, videomode, videomode_supported, dpi, monitor)
end

#Came from GLWindow/core.jl
function Base.show(io::IO, m::MonitorProperties)
    println(io, "name: ", m.name)
    println(io, "physicalsize: ",  m.physicalsize[1], "x", m.physicalsize[2])
    println(io, "resolution: ", m.videomode.width, "x", m.videomode.height)
    println(io, "dpi: ", m.dpi[1], "x", m.dpi[2])
end