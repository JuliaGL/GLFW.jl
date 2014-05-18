# version of library to download
const version = VersionNumber(3, 0, 4)
const glfw = "glfw-$version"

map(mkpath, ("downloads", "usr"))

# download and compile the library from source
@unix_only begin
	const tarball = "downloads/$glfw.tar.gz"
	if !isfile(tarball)
		info("Downloading GLFW $version source tarball")
		download("https://github.com/glfw/glfw/archive/$version.tar.gz", tarball)
	end
	mkpath("src")
	run(`tar xzf $tarball -C src`)
	mkpath("builds/$glfw")
	cd("builds/$glfw") do
		options = map(x -> "-D$(x[1])=$(x[2])", [
			"BUILD_SHARED_LIBS"     => "ON",
			"CMAKE_INSTALL_PREFIX"  => "../../usr",
			"GLFW_BUILD_DOCS"       => "OFF",
			"GLFW_BUILD_EXAMPLES"   => "OFF",
			"GLFW_BUILD_TESTS"      => "OFF"
		])
		run(`cmake $options ../../src/$glfw`)
		run(`make install`)
	end
end

# download a pre-compiled binary
@windows_only begin
	const build = "$glfw.bin.WIN$WORD_SIZE"
	const archive = "downloads/$build.zip"
	if !isfile(archive)
		info("Downloading pre-compiled GLFW $version binary for $WORD_SIZE-bit Windows")
		download("https://github.com/jayschwa/glfw/releases/download/$version/$build.zip", archive)
	end
	run(`7z x -obuilds -y $archive`)
	run(`cp -R builds/$build/lib-mingw usr/lib`)
end
