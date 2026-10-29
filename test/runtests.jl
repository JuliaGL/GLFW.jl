using GLFW, Test

@test !GLFW.is_initialized()
println(GLFW.GetVersionString())
@test !GLFW.is_initialized()

# GLFWError uses enum for known error code
@test isa(GLFW.GLFWError(GLFW.NOT_INITIALIZED, "").code, GLFW.ErrorCode)
@test GLFW.GLFWError(0x00010001, "").code == GLFW.NOT_INITIALIZED

# GLFWError uses integer for unrecognized error code
@test isa(GLFW.GLFWError(0xDEADBEEF, "").code, Integer)

# https://github.com/JuliaGL/GLFW.jl/pull/225
@test GLFW.PRESS == true
@test true == GLFW.PRESS
@test GLFW.RELEASE == false
@test false == GLFW.RELEASE

@testset "platform selection" begin
	@test GLFW.PLATFORM_BY_NAME["x11"] == GLFW.PLATFORM_X11
	@test GLFW.PLATFORM_BY_NAME["null"] == GLFW.PLATFORM_NULL

	withenv("JULIA_GLFW_PLATFORM" => nothing) do
		@test GLFW.RequestedPlatform() === nothing
	end
	withenv("JULIA_GLFW_PLATFORM" => "wayland") do
		@test GLFW.RequestedPlatform() == GLFW.PLATFORM_WAYLAND
		# A named platform is used alone, so failing to init it stays fatal.
		@test GLFW.InitCandidates() == [GLFW.PLATFORM_WAYLAND]
	end
	# An unrecognized name is not a request for a specific platform.
	withenv("JULIA_GLFW_PLATFORM" => "not-a-platform") do
		@test (@test_logs (:warn,) match_mode = :any GLFW.RequestedPlatform()) == GLFW.ANY_PLATFORM
	end

	# The NULL platform is the last resort: a platform that can actually open
	# windows must be tried first, otherwise a machine where only some
	# platforms work (e.g. Wayland but not X11) silently loses windowing.
	candidates = withenv(GLFW.InitCandidates, "JULIA_GLFW_PLATFORM" => nothing)
	@test first(candidates) == GLFW.OS_DEFAULT_PLATFORM
	@test GLFW.ANY_PLATFORM in candidates
	@test allunique(candidates)
	if GLFW.PlatformSupported(GLFW.PLATFORM_NULL)
		@test last(candidates) == GLFW.PLATFORM_NULL
		@test findfirst(==(GLFW.ANY_PLATFORM), candidates) < length(candidates)
		# An explicit "any" must still get the NULL fallback appended.
		any_candidates = withenv(GLFW.InitCandidates, "JULIA_GLFW_PLATFORM" => "any")
		@test any_candidates == [GLFW.ANY_PLATFORM, GLFW.PLATFORM_NULL]
	end
end

if Sys.islinux()
	# Importing does not initialize GLFW; first use falls back to
	# the NULL platform (#169, #200, #253). Checked in subprocesses so this
	# process's initialized GLFW is not disturbed. XDG_RUNTIME_DIR is pointed
	# at an empty directory as well, otherwise libwayland still finds its
	# default socket there and we would not be testing the headless path.
	base = `$(Base.julia_cmd()) --project=$(dirname(Base.active_project())) --startup-file=no`
	emptydir = mktempdir()
	headless = copy(ENV)
	delete!(headless, "DISPLAY")
	delete!(headless, "WAYLAND_DISPLAY")
	delete!(headless, "JULIA_GLFW_PLATFORM")
	headless["XDG_RUNTIME_DIR"] = emptydir

	loads_on_null = "using GLFW; print(!GLFW.is_initialized() && GLFW.GetPlatform() == GLFW.PLATFORM_NULL && GLFW.is_initialized())"
	if GLFW.PlatformSupported(GLFW.PLATFORM_NULL)
		@test read(setenv(`$base -e $loads_on_null`, headless), String) == "true"

		# "any" is not a request for a specific platform, so it must fall back
		# too rather than being treated as an explicit demand.
		any_env = copy(headless)
		any_env["JULIA_GLFW_PLATFORM"] = "any"
		@test read(setenv(`$base -e $loads_on_null`, any_env), String) == "true"

		# An unrecognized value is ignored with a warning, not obeyed.
		junk_env = copy(headless)
		junk_env["JULIA_GLFW_PLATFORM"] = "not-a-platform"
		@test read(setenv(`$base -e $loads_on_null`, junk_env), String) == "true"
	end

	# Import succeeds even with an unavailable requested platform. Explicit
	# Init returns false; implicit initialization throws before using GLFW.
	x11_env = copy(headless)
	x11_env["JULIA_GLFW_PLATFORM"] = "x11"
	imports = setenv(`$base -e "using GLFW; print(!GLFW.is_initialized())"`, x11_env)
	@test read(imports, String) == "true"
	init_fails = setenv(`$base -e "using GLFW; print(!GLFW.Init() && !GLFW.is_initialized())"`, x11_env)
	@test read(init_fails, String) == "true"
	failing = setenv(`$base -e "using GLFW; GLFW.GetPlatform()"`, x11_env)
	@test !success(pipeline(failing, stdout = devnull, stderr = devnull))
end

include("initialization.jl")
include("headless.jl")

if !haskey(ENV, "CI") && GLFW.GetPlatform() != GLFW.PLATFORM_NULL
	include("windowclose.jl")
end
