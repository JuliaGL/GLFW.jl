# version of library to download
const version = "3.1"
const glfw = "glfw-$version"

# TODO: if the latest version is already installed, don't bother with any of this

# download and compile the library from source
@linux_only begin
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
		info("Building GLFW $version library from source")
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
	catch e
		warn(e)
		warn("""
On Linux, you might not have xorg-dev and libglu1-mesa-dev installed, which you can get via the commandline with for example
sudo apt-get install  xorg-dev libglu1-mesa-dev
If that doesn't help, try to install GLFW manually
(see http://www.glfw.org/download.html for more information)""")
	end
end

# download a pre-complied binary (built by Homebrew)
@osx_only begin
	const osx_version = convert(VersionNumber, readall(`sw_vers -productVersion`))
	if osx_version >= v"10.10"
		codename = "yosemite"
	elseif osx_version >= v"10.9"
		codename = "mavericks"
	else
		codename = "mountain_lion"
	end
	const tarball = "glfw3-$version.$codename.bottle.tar.gz"
	if (!isfile("downloads/$tarball"))
		info("Downloading pre-compiled GLFW $version binary")
		mkpath("downloads")
		download("https://homebrew.bintray.com/bottles-versions/$tarball", "downloads/$tarball")
	end
	mkpath("builds")
	run(`tar xzf downloads/$tarball -C builds`)
	mkpath("usr64")

	# Using `mv` since `cp` seems broken: https://github.com/JuliaLang/julia/issues/10434
	# TODO: Re-check when min version is Julia 0.4
	try rm("usr64/lib", recursive=true) end
	mv("builds/glfw3/$version/lib", "usr64/lib")
end

# download a pre-compiled binary (built by GLFW)
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

		# Using `mv` since `cp` seems broken: https://github.com/JuliaLang/julia/issues/10434
		# TODO: Re-check when min version is Julia 0.4
		try rm("usr$sz/lib", recursive=true) end
		mv("builds/$build/lib-mingw", "usr$sz/lib")
	end
end
