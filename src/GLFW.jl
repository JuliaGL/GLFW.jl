__precompile__()

module GLFW

include("compat.jl")
include("../deps/deps.jl")

function GetVersion()
	major, minor, rev = Ref{Cint}(), Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetVersion, lib), Cvoid, (Ref{Cint}, Ref{Cint}, Ref{Cint}), major, minor, rev)
	VersionNumber(major[], minor[], rev[])
end

include("callback.jl")
include("glfw3.jl")
include("vulkan.jl")

if isdefined(Base, :getproperty) && isdefined(Base, :setproperty!)
	# Julia 0.7 supports property overloading
	# TODO for Julia upgrade: remove feature guard
	include("monitor_properties.jl")
end

const GLFW_INITIALIZED = Ref(false)

is_initialized() = GLFW_INITIALIZED[]


function __init__()
	check_deps()

	libversion = GetVersion()

	if libversion.major != 3
		error("GLFW version $libversion not supported")
	end
	# Save errors that occur during initialization
	errors = Vector{Exception}()
	SetErrorCallback(err -> push!(errors, err))

	try
		GLFW_INITIALIZED[] = GLFW.Init()
	catch err
		push!(errors, err)
	finally
		SetErrorCallback(throw)
	end

	if GLFW_INITIALIZED[]
		atexit() do
			GLFW.Terminate()
			GLFW_INITIALIZED[] = false
		end
		for err in errors
			warn(err)  # Warn about any non-fatal errors that may have occurred during initialization
		end
	else
		throw(errors)  # Throw fatal errors
	end
end

end
