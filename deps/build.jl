const version = v"3.2.1"

using BinDeps
@BinDeps.setup

glfw = library_dependency("libglfw", aliases=["glfw", "glfw3", "libglfw3"])

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
		MakeTargets(["install"])
	end
end
provides(SimpleBuild, cmake_build_steps, glfw)

# get library through Homebrew, if available
if Pkg.installed("Homebrew") != nothing
	using Homebrew
	provides(Homebrew.HB, "homebrew/versions/glfw3", glfw, os=:Darwin)
end

# download a pre-compiled binary (built by GLFW)
if is_windows()
	# TODO: Binaries from GitHub
end

@BinDeps.install Dict("libglfw"=>"lib")
