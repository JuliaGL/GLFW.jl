__precompile__()

module GLFW

include("compat.jl")
include("../deps/deps.jl")

function GetVersion()
	major, minor, rev = Ref{Cint}(), Ref{Cint}(), Ref{Cint}()
	ccall( (:glfwGetVersion, lib), Cvoid, (Ref{Cint}, Ref{Cint}, Ref{Cint}), major, minor, rev)
	VersionNumber(major[], minor[], rev[])
end
const libversion = GetVersion()

if libversion.major == 3
	include("callback.jl")
	include("glfw3.jl")
	include("vulkan.jl")
	if isdefined(Base, :getproperty) && isdefined(Base, :setproperty!)
		# Julia 0.7 supports property overloading
		# TODO for Julia upgrade: remove feature guard
		include("monitor_properties.jl")
	end
else
	error("GLFW $libversion is not supported")
end

function __init__()
	initialized = false

	# Save errors that occur during initialization
	errors = Vector{Exception}()
	SetErrorCallback(err -> push!(errors, err))

	try
		initialized = GLFW.Init()
	catch err
		push!(errors, err)
	finally
		SetErrorCallback(throw)
	end

	if initialized
		atexit(GLFW.Terminate)
		for err in errors
			warn(err)  # Warn about any non-fatal errors that may have occurred during initialization
		end
	else
		throw(errors)  # Throw fatal errors
	end
end

end
