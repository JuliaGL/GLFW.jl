VERSION >= v"0.4.0-dev+6521" && __precompile__(true)
module GLFW

using Compat # Backport some Julia 0.4 stuff to 0.3. Remove when Julia 0.3 is no longer supported.



include("util.jl")
isfile(joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")) || error("GLFW was not build properly. Please run Pkg.build(\"GLFW\")")
include(joinpath("..", "deps", "deps.jl"))


function GetVersion()
	major, minor, rev = Cint[0], Cint[0], Cint[0]
	ccall( (:glfwGetVersion, lib), Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), major, minor, rev)
	VersionNumber(major[1], minor[1], rev[1])
end

if GLFW_VERSION.major == 2
	include("glfw2.jl")
	GetVersionString() = string(GLFW_VERSION)
	for f in (:CreateWindow, :WindowHint, :DefaultWindowHints, :GetMonitors, :GetPrimaryMonitor)
		@eval $f(any...) = error($f, " is not supported by GLFW $GLFW_VERSION, use a newer version of the library")
	end
elseif GLFW_VERSION.major == 3
	include("glfw3.jl")
	SetErrorCallback((code, description) -> error(description))
	for f in (:OpenWindow, :OpenWindowHint, :GetDesktopMode)
		@eval $f(any...) = error($f, " is obsolete and not supported by newer versions of GLFW")
	end
else
	error("GLFW $GLFW_VERSION is not supported")
end


function __init__()
	GetVersion() != GLFW_VERSION && error("
		GLFW version from build ($(GLFW_VERSION)) does not match up with the GLFW version loaded at runtime. Please run `Pkg.build(\"GLFW\")
	")
end

end
