module GLFW

const lib = "libglfw"

##### Initialization and Termination

function Init()
	ret = ccall( (:glfwInit, lib), Int32, ())
	if ret != 1
		error("initialization failed")
	end
end

function Terminate()
	ccall( (:glfwTerminate, lib), Void, ())
end

##### Window Handling

function OpenWindow(width::Integer, height::Integer, redbits::Integer,
	greenbits::Integer, bluebits::Integer, alphabits::Integer,
	depthbits::Integer, stencilbits::Integer, mode::Integer)

	ret = ccall( (:glfwOpenWindow, lib), Int32,
		(Int32, Int32, Int32, Int32, Int32, Int32, Int32, Int32, Int32),
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
	ccall( (:glfwOpenWindowHint, lib), Void, (Int32, Int32), target, hint)
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
	cfunc = cfunction(callback, Int32, ())
	ccall( (:glfwSetWindowCloseCallback, lib), Void, (Ptr{Void},), cfunc)
end

function SetWindowTitle(title::String)
	ccall( (:glfwSetWindowTitle, lib), Void, (Ptr{Uint8},), bytestring(title))
end

function SetWindowSizeCallback(callback::Function)
	cfunc = cfunction(callback, Void, (Int32, Int32))
	ccall( (:glfwSetWindowSizeCallback, lib), Void, (Ptr{Void},), cfunc)
end

function GetWindowParam(param::Integer)
	ret = ccall( (:glfwGetWindowParam, lib), Int32, (Int32,), param)
	if contains(boolParams, param)
		ret == 1
	else
		ret
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

end # module

