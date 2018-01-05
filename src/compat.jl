# Shims for using Julia 0.7 constructs in 0.6.

if !isdefined(Base, :Cvoid)
	const Cvoid = Void
end

if !isdefined(Base, :Nothing)
	const Nothing = Void
end
