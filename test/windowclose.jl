import GLFW
using Base.Test

window = GLFW.CreateWindow(800, 600, "InexactError")
@test !GLFW.WindowShouldClose(window)
# If you call the julia function GLFW.SetWindowShouldClose(window,
# truefalse), then only 0 or 1 can be passed. However, at least on
# some platforms (Linux), clicking on the window's close icon can send
# other values (like 189). Make sure such values don't cause trouble for
# GLFW.WindowShouldClose.
ccall( (:glfwSetWindowShouldClose, GLFW.lib), Void, (GLFW.WindowHandle, Cint), window, 189)
@test GLFW.WindowShouldClose(window)


# Test for a segfault triggered by a scheduled task
using ModernGL, GeometryTypes
window = GLFW.CreateWindow(1024, 768, "Segfault")
GLFW.MakeContextCurrent(window)

vao = Ref(GLuint(0))
glGenVertexArrays(1, vao)
glBindVertexArray(vao[])

vbo = Ref(GLuint(0))
glGenBuffers(1, vbo)
glBindBuffer(GL_ARRAY_BUFFER, vbo[])
vertices = Point3f0[(-1,-1,0), (1,-1,0), (0, 1, 1)]
glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW)

glEnableVertexAttribArray(0)
glBindBuffer(GL_ARRAY_BUFFER, vbo[])
glVertexAttribPointer(0, length(vertices), GL_FLOAT, GL_FALSE, 0, C_NULL)

function render()
    glDrawArrays(GL_TRIANGLES, 0, length(vertices))
    GLFW.SwapBuffers(window)
    GLFW.PollEvents()
end

schedule(Task(render))

GLFW.DestroyWindow(window)

sleep(0.25)
