const version = VersionNumber(3, 0, 4)

map(mkpath, ("downloads", "src", "builds", "usr"))

@unix_only begin
	const glfw = "glfw-$version"
	tarball = "downloads/$glfw.tar.gz"
	if !isfile(tarball)
		download("https://github.com/glfw/glfw/archive/$version.tar.gz", tarball)
	end
	run(`tar xzf $tarball -C src`)
	mkpath("builds/$glfw")
	cd("builds/$glfw") do
		run(`cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=../../usr -DGLFW_BUILD_DOCS=OFF -DGLFW_BUILD_EXAMPLES=OFF -DGLFW_BUILD_TESTS=OFF ../../src/$glfw`)
		run(`make install`)
	end
end

# Automagically download and install a GLFW DLL for the poor souls using Windows
@windows_only begin
	const dll = "glfw3.dll"
	const archive = "glfw-$version.bin.WIN$WORD_SIZE.zip"

	if !(dll in readdir() && archive in readdir())
		info("Downloading GLFW $version binary for $WORD_SIZE-bit Windows")
		download("https://github.com/jayschwa/glfw/releases/download/$version/$archive", archive)
		run(`7z e -y $archive glfw-*/lib-mingw/$dll`)
		info("Installed $dll in $(pwd())")
	else
		info("$dll already exists in $(pwd())")
	end
end
