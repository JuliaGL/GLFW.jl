# GLFW.jl

[![CI](https://github.com/JuliaGL/GLFW.jl/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/JuliaGL/GLFW.jl/actions/workflows/ci.yml)


[Julia][julia] interface to [GLFW 3][glfw], a multi-platform library for creating windows with [OpenGL][opengl] or OpenGL ES contexts and receiving many kinds of input. GLFW has native support for Windows, OS X and many Unix-like systems using the X Window System, such as Linux and FreeBSD.

The Julia package version follows its own API changes independently of the C library version. Use `GLFW.GetVersion()` to query the C library version; the `GLFW_jll` compatibility entry in `Project.toml` specifies supported library versions.

[julia]:  https://julialang.org
[glfw]:   https://www.glfw.org
[opengl]: https://wikipedia.org/wiki/OpenGL


Example
-------

```julia
using GLFW

# Create a window and its OpenGL context
window = GLFW.CreateWindow(640, 480, "GLFW.jl")

# Make the window's context current
GLFW.MakeContextCurrent(window)

# Loop until the user closes the window
while !GLFW.WindowShouldClose(window)

	# Render here

	# Swap front and back buffers
	GLFW.SwapBuffers(window)

	# Poll for and process events
	GLFW.PollEvents()
end

GLFW.DestroyWindow(window)
```

Interface
---------

Read the [GLFW documentation][docs] for detailed instructions on how to use the library. The Julia interface is almost identical to the underlying C interface, with a few notable differences:

* Clipboard (`glfwGetClipboard`, `glfwSetClipboard`) and time (`glfwGetTime`, `glfwSetTime`) functions have been omitted because Julia's standard library already supports similar functionality.
* Importing GLFW does not initialize it or connect to a display server. Entry points such as window and cursor creation, window hints, monitor discovery, and independent Vulkan queries initialize it automatically. Operations on existing handles assume their session is initialized. `GLFW.InitHint`, version queries, `GLFW.PlatformSupported`, and `GLFW.SetErrorCallback` remain usable before initialization. `GLFW.Terminate()` is called at exit and can also be called explicitly; create new handles when starting another session.
* Monitor queries and callbacks return `GLFW.Monitor` values, including `Monitor(C_NULL)` when no monitor is available. Null monitors are accepted for windowed-mode parameters; accessing monitor properties with one throws an `ArgumentError` before calling C. `GetMonitors()` returns a Julia-owned vector of wrapped handles.
* `GLFW.Init()` returns a `Bool`. Initialization failures warn by default and return `false`; implicit initialization throws if `Init()` fails. A custom error callback receives initialization errors and may itself throw. Other GLFW operations retain their default throwing error callback. Repeated `Init()` calls after success preserve the selected platform and window hints.
* Initialization first tries the OS default, then lets GLFW pick any available window system (so a machine with Wayland but no X11 still works), and finally warns and falls back to the NULL platform. Check for it with `GLFW.GetPlatform() == GLFW.PLATFORM_NULL`. NULL has no visible windows. It supports offscreen OpenGL, and may support Vulkan headless surfaces if the driver provides `VK_EXT_headless_surface`. Ordinary offscreen Vulkan does not need a GLFW window or surface.
* On NULL, OpenGL window creation automatically tries EGL and then OSMesa. Explicit `CONTEXT_CREATION_API` hints are honored. `CLIENT_API = NO_API` never tries to create an OpenGL context. Window hints survive automatic context selection; `DefaultWindowHints()` restores automatic selection. Shared windows use the source window's context API.
* The `JULIA_GLFW_PLATFORM` environment variable (`"win32"`, `"cocoa"`, `"wayland"`, `"x11"`, `"null"`, or `"any"`) selects a platform when initialization is first needed. An explicit `GLFW.Init(platform = ...)` takes precedence. Named platforms are tried alone: `Init()` returns `false` on failure instead of falling back. `"null"` enables intentional headless use without display probing or fallback warnings. `"any"` and unrecognized values retain the fallbacks above; an unrecognized value additionally warns.
* `GLFW.GetRequiredInstanceExtensions()` returns an empty `Vector{String}` when Vulkan is available but window surface extensions are unavailable. `GLFW.CreateWindowSurface` throws on a failed `VkResult` even if the error callback does not throw.
* Initialization must happen on the main thread. Operations documented as safe on any thread remain so after initialization; explicitly initialize on the main thread before calling them from another thread.
* Thread restrictions are explicitly checked and throw errors when they are not respected. This can be turned off by setting `GLFW.ENABLE_THREAD_ASSERTIONS[] = false` or by setting an environment variable of the same name.

[docs]: https://www.glfw.org/docs/latest/

Headless rendering
------------------

With GLFW.jl 4, importing GLFW or a Vulkan renderer does not connect to a display.
For offscreen OpenGL, create a hidden window normally:

```julia
using GLFW
window = GLFW.Window(visible = false, resolution = (640, 480))
# Render and read back pixels with OpenGL here.
GLFW.DestroyWindow(window)
```

Without a display, EGL is selected automatically and OSMesa is tried if EGL fails.
EGL can use a GPU driver or Mesa software rendering. An OpenGL implementation must
still be installed; GLFW does not supply a graphics driver. If neither EGL nor
OSMesa works, the error includes both failures. `ShowWindow` and the high-level
`Window(visible = true)` constructor report that NULL cannot show a window.

For deterministic headless workers, set `JULIA_GLFW_PLATFORM=null` before the first
GLFW operation. This skips display probing and fallback warnings. Setting it is
optional: missing displays also fall back automatically.

Vulkan compute and rendering into images need no GLFW initialization. Only query
`GetRequiredInstanceExtensions()` when creating a GLFW window surface; an empty
list means that surface creation is unavailable, not that offscreen Vulkan is.

On Linux, a system Mesa EGL vendor may require newer Wayland symbols than an old
environment's bundled Wayland library provides, even for surfaceless rendering.
For example, `wl_fixes_interface` requires a recent Wayland runtime. Update the
graphics dependencies together or use a graphics environment with compatible
versions. `Libdl.dlopen("libEGL_mesa.so.0")` can expose such vendor load errors.


Footnotes
---------

* Special thanks to [@afterwise](https://github.com/afterwise) for writing an early implementation of GLFW 3 support.
