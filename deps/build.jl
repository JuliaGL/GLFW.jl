# version of library to download
const version = v"3.2.1"

using BinDeps, Libdl
@BinDeps.setup

function compatible_version(lib, handle)
	major, minor, rev = Ref{Cint}(), Ref{Cint}(), Ref{Cint}()
	ccall(Libdl.dlsym(handle, :glfwGetVersion), Cvoid, (Ref{Cint}, Ref{Cint}, Ref{Cint}), major, minor, rev)
	libversion = VersionNumber(major[], minor[], rev[])
	return libversion >= version
end

glfw = library_dependency("glfw", aliases=["glfw", "glfw3", "libglfw", "libglfw3"], validate=compatible_version)

# library source code
provides(Sources, URI("https://github.com/glfw/glfw/archive/$version.tar.gz"), glfw, unpacked_dir="glfw-$version")
srcdir = joinpath(BinDeps.srcdir(glfw), "glfw-$version")

# build library from source
@static if Sys.islinux()
	using CMakeWrapper
	cmake_options = map(x -> "-D$(x[1])=$(x[2])", [
		("BUILD_SHARED_LIBS",   "ON"),
		("GLFW_BUILD_DOCS",     "OFF"),
		("GLFW_BUILD_EXAMPLES", "OFF"),
		("GLFW_BUILD_TESTS",    "OFF")
	])
	provides(BuildProcess, CMakeProcess(cmake_args=cmake_options), glfw)
end

# get library through Homebrew, if available
@static if Sys.isapple()
	using Homebrew
	provides(Homebrew.HB, "glfw", glfw, os=:Darwin)
end

# download a pre-compiled binary (built by GLFW)
@static if Sys.iswindows()
	archive = "glfw-$version.bin.WIN$(Sys.WORD_SIZE)"
	libpath = joinpath(archive, "lib-mingw-w64")
	uri = URI("https://github.com/glfw/glfw/releases/download/$version/$archive.zip")
	provides(Binaries, uri, glfw, unpacked_dir=archive, installed_libpath=libpath, os=:Windows)
end

@BinDeps.install Dict("glfw"=>"lib")
