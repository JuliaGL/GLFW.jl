using GLFW, Test

window = GLFW.CreateWindow(800, 600, "InexactError")
@test !GLFW.WindowShouldClose(window)
# If you call the julia function GLFW.SetWindowShouldClose(window,
# truefalse), then only 0 or 1 can be passed. However, at least on
# some platforms (Linux), clicking on the window's close icon can send
# other values (like 189). Make sure such values don't cause trouble for
# GLFW.WindowShouldClose.
ccall((:glfwSetWindowShouldClose, GLFW.lib), Cvoid, (GLFW.Window, Cint), window, 189)
@test GLFW.WindowShouldClose(window)
GLFW.DestroyWindow(window)
