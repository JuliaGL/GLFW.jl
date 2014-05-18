# version of library to download
const version = VersionNumber(3, 0, 4)
const glfw = "glfw-$version"

map(mkpath, ("downloads", "usr"))

# download and compile the library from source
@unix_only begin
	const tarball = "downloads/$glfw.tar.gz"
	if !isfile(tarball)
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
	const dll = "glfw3.dll"
	const archive = "$glfw.bin.WIN$WORD_SIZE.zip"
	if !(dll in readdir() && archive in readdir())
		info("Downloading GLFW $version binary for $WORD_SIZE-bit Windows")
		download("https://github.com/jayschwa/glfw/releases/download/$version/$archive", archive)
		run(`7z e -y $archive glfw-*/lib-mingw/$dll`)
		info("Installed $dll in $(pwd())")
	else
		info("$dll already exists in $(pwd())")
	end
end
