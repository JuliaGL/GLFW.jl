#came from GLWindow/core.jl
"""
Returns the monitor resolution of the primary monitor.
"""
function primarymonitorresolution()
    props = MonitorProperties(GetPrimaryMonitor())
    w,h = props.videomode.width, props.videomode.height
    # Vec(Int(w),Int(h))
    Vector([Int(w),Int(h)])
end

#Came from GLWindow.jl/screen.jl


#question: Is this correct?
"""
Takes a Window and registers a list of callback functions.
Returns a Dict{Symbol, Any}(name_of_callback => signal)
"""
function register_callbacks(window::Window, callbacks::Vector{Function})
    tmp = map(callbacks) do f
        (Symbol(last(split(string(f),"."))), f(window))
    end
    Dict{Symbol, Any}(tmp)
end

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

#question: what is this exactly?
full_screen_usage_message() = """
Keyword arg fullscreen accepts:
    Integer: The number of the Monitor to Select
    Bool: if true, primary monitor gets fullscreen, false no fullscren (default)
    GLFW.Monitor: Fullscreens on the passed monitor
"""

function poll_glfw()
    PollEvents()
end

#Came from: GLWindow/events.jl
function to_arrow_symbol(button_set)
    for b in button_set
        KEY_RIGHT == b && return :right
        KEY_LEFT  == b && return :left
        KEY_DOWN  == b && return :down
        KEY_UP    == b && return :up
    end
    return :nothing
end

# this came from GLWindow/screen.jl 

