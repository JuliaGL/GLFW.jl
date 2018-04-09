include("../src/compat.jl")

# version of library to download
const version = v"3.2.1"

using BinDeps
@BinDeps.setup

if !isdefined(Base, :Libdl)
	# TODO for Julia upgrade: remove check
	using Libdl
end

function compatible_version(lib, handle)
	major, minor, rev = Ref{Cint}(), Ref{Cint}(), Ref{Cint}()
	ccall(Libdl.dlsym(handle, :glfwGetVersion), Cvoid, (Ref{Cint}, Ref{Cint}, Ref{Cint}), major, minor, rev)
	libversion = VersionNumber(major[], minor[], rev[])
	return libversion >= version
end

glfw = library_dependency("libglfw", aliases=["glfw", "glfw3", "libglfw3"], validate=compatible_version)

# library source code
provides(Sources, URI("https://github.com/glfw/glfw/archive/$version.tar.gz"), glfw, unpacked_dir="glfw-$version")
srcdir = joinpath(BinDeps.srcdir(glfw), "glfw-$version")

# how to build library from source
cmake_options = map(x -> "-D$(x[1])=$(x[2])", [
	("BUILD_SHARED_LIBS",    "ON"),
	("CMAKE_INSTALL_PREFIX", BinDeps.usrdir(glfw)),
	("GLFW_BUILD_DOCS",      "OFF"),
	("GLFW_BUILD_EXAMPLES",  "OFF"),
	("GLFW_BUILD_TESTS",     "OFF")
])
cmake_build_steps = @build_steps begin
	GetSources(glfw)
	@build_steps begin
		ChangeDirectory(srcdir)
		`cmake $cmake_options .`
		MakeTargets("install")
	end
end
provides(SimpleBuild, cmake_build_steps, glfw)

# get library through Homebrew, if available
if isapple()
	using Homebrew
	provides(Homebrew.HB, "glfw", glfw, os=:Darwin)
end

# download a pre-compiled binary (built by GLFW)
if iswindows()
	archive = "glfw-$version.bin.WIN$(Sys.WORD_SIZE)"
	libpath = joinpath(archive, "lib-mingw-w64")
	uri = URI("https://github.com/glfw/glfw/releases/download/$version/$archive.zip")
	provides(Binaries, uri, glfw, unpacked_dir=archive, installed_libpath=libpath, os=:Windows)
end

@BinDeps.install Dict("libglfw"=>"lib")
