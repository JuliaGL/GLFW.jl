# version of library to download
const version = VersionNumber(3, 0, 4)
const glfw = "glfw-$version"

# download and compile the library from source
@unix_only begin
    function cmakebuild()
 	cd("builds/$glfw") do
	    options = map(x -> "-D$(x[1])=$(x[2])", [
                            "BUILD_SHARED_LIBS"     => "ON",
                            "CMAKE_INSTALL_PREFIX"  => "../../usr$WORD_SIZE",
                            "GLFW_BUILD_DOCS"       => "OFF",
                            "GLFW_BUILD_EXAMPLES"   => "OFF",
                             "GLFW_BUILD_TESTS"      => "OFF"
               ])
	    run(`cmake $options ../../src/$glfw`)
	    run(`make install`)
        end
    end
    mkpath("downloads")
    const tarball = "downloads/$glfw.tar.gz"
    if !isfile(tarball)
	info("Downloading GLFW $version source tarball")
	download("https://github.com/glfw/glfw/archive/$version.tar.gz", tarball)
    end
    mkpath("src")
    run(`tar xzf $tarball -C src`)
    map(mkpath, ("builds/$glfw", "usr$WORD_SIZE"))
    try
        cmakebuild()
    catch
        run(`sudo apt-get -u install xorg-dev libglu1-mesa-dev`)
        cmakebuild()
    end
end

# download a pre-compiled binary
@windows_only begin
	mkpath("downloads")
	for sz in (32, 64)
		const build = "$glfw.bin.WIN$sz"
		const archive = "downloads/$build.zip"
		if !isfile(archive)
			info("Downloading pre-compiled GLFW $version $sz-bit binary")
			download("https://github.com/jayschwa/glfw/releases/download/$version/$build.zip", archive)
		end
		run(`7z x -obuilds -y $archive`)
		mkpath("usr$sz")
		run(`cp -R builds/$build/lib-mingw usr$sz/lib`)
	end
end
