module GLFW

using Base.Sys: isapple, iswindows

include("../deps/deps.jl")

function GetVersion()
	major, minor, rev = Ref{Cint}(), Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetVersion, lib), Cvoid, (Ref{Cint}, Ref{Cint}, Ref{Cint}), major, minor, rev)
	VersionNumber(major[], minor[], rev[])
end

include("callback.jl")
include("glfw3.jl")
include("vulkan.jl")
include("monitor_properties.jl")

const GLFW_INITIALIZED = Ref(false)

is_initialized() = GLFW_INITIALIZED[]

function __init__()
	libversion = GetVersion()

	if libversion.major != 3
		error("GLFW version $libversion not supported")
	end

	# Save errors that occur during initialization
	errors = Vector{Exception}()
	SetErrorCallback(err -> push!(errors, err))

	try
		Init()
	catch err
		push!(errors, err)
	finally
		SetErrorCallback(throw)
	end

	if is_initialized()
		atexit(Terminate)
		for err in errors
			@warn err  # Warn about any non-fatal errors that may have occurred during initialization
		end
	else
		throw(errors)  # Throw fatal errors
	end
end

end
