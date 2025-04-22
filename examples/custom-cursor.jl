using GLFW

pixels = fill((0x00,0x00,0x00,0x00), 32, 32)
fill!(@view(pixels[1:5,1:5]), (0xff,0xff,0xff,0xff)) # top left = white
fill!(@view(pixels[27:32,27:32]), (0xff,0x00,0x00,0xff)) # bottom right = red
fill!(@view(pixels[27:32,1:5]), (0x00,0xff,0x00,0xff)) # top left green
fill!(@view(pixels[1:5,27:32]), (0x00,0x00,0xff,0xff)) # top right blue

window = GLFW.CreateWindow(640, 480, "Custom Cursor")
GLFW.MakeContextCurrent(window)
GLFW.SetCursor(window, GLFW.CreateCursor(pixels, (16, 16)))
while !GLFW.WindowShouldClose(window)
	GLFW.SwapBuffers(window)
	GLFW.WaitEvents()
end

GLFW.DestroyWindow(window)
