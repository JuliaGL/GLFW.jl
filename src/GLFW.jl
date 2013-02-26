module GLFW

const lib = "libglfw"

function Init()
	ccall( (:glfwInit, lib), Int32, ()) == 1
end

# OpenWindow modes
const WINDOW     = 0x00010001
const FULLSCREEN = 0x00010002

function OpenWindow(width::Integer, height::Integer, redbits::Integer,
	greenbits::Integer, bluebits::Integer, alphabits::Integer,
	depthbits::Integer, stencilbits::Integer, mode::Integer)

	ccall( (:glfwOpenWindow, lib), Int32,
		(Int32, Int32, Int32, Int32, Int32, Int32, Int32, Int32, Int32),
		width, height, redbits, greenbits, bluebits, alphabits, depthbits,
		stencilbits, mode) == 1
end

end # module

