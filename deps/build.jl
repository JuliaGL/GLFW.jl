# Automagically download and install a GLFW DLL for the poor souls using Windows
@windows_only begin
	const version = "3.0.4"
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