using GLFW, Test

@testset "WindowShouldClose" begin
    window = GLFW.CreateWindow(800, 600, "InexactError")
    @test !GLFW.WindowShouldClose(window)
    # If you call the julia function GLFW.SetWindowShouldClose(window,
    # truefalse), then only 0 or 1 can be passed. However, at least on
    # some platforms (Linux), clicking on the window's close icon can send
    # other values (like 189). Make sure such values don't cause trouble for
    # GLFW.WindowShouldClose.
    ccall((:glfwSetWindowShouldClose, GLFW.libglfw), Cvoid, (GLFW.Window, Cint), window, 189)
    @test GLFW.WindowShouldClose(window)
    GLFW.DestroyWindow(window)
end

@testset "SetWindowIcon" begin
    window = GLFW.CreateWindow(800, 600, "InexactError")
    icon = reshape([repeat([(0x00, 0x00, 0x00, 0x00)], 128 * 128)...], (128,128))
    # 2 methods, test both:
    GLFW.SetWindowIcon(window, icon)
    GLFW.SetWindowIcon(window, [icon])
    GLFW.DestroyWindow(window)
end
