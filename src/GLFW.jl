module GLFW

using Compat # Backport some Julia 0.4 stuff to 0.3. Remove when Julia 0.3 is no longer supported.

const lib = Libdl.find_library(["glfw3", "libglfw3", "glfw", "libglfw"], [Pkg.dir("GLFW/deps/usr$WORD_SIZE/lib")])
if isempty(lib)
	error("could not find GLFW library")
end

include("util.jl")

function GetVersion()
	major, minor, rev = Cint[0], Cint[0], Cint[0]
	ccall( (:glfwGetVersion, lib), Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), major, minor, rev)
	VersionNumber(major[1], minor[1], rev[1])
end
const VERSION = GetVersion()

if VERSION.major == 2
	include("glfw2.jl")
	GetVersionString() = string(VERSION)
	for f in (:CreateWindow, :WindowHint, :DefaultWindowHints, :GetMonitors, :GetPrimaryMonitor)
		@eval $f(any...) = error($f, " is not supported by GLFW $VERSION, use a newer version of the library")
	end
elseif VERSION.major == 3
	include("glfw3.jl")
	SetErrorCallback((code, desc) -> error(bytestring(desc)))
	for f in (:OpenWindow, :OpenWindowHint, :GetDesktopMode)
		@eval $f(any...) = error($f, " is obsolete and not supported by newer versions of GLFW")
	end
else
	error("GLFW $VERSION is not supported")
end


end
