# Shims for using Julia 0.7 constructs in 0.6.

if !isdefined(Base, :Cvoid)
	const Cvoid = Void
end

if !isdefined(Base, :Nothing)
	const Nothing = Void
end

if !isdefined(Sys, :isapple)
	Sys.eval(:(isapple = is_apple))
end

if !isdefined(Sys, :iswindows)
	Sys.eval(:(iswindows = is_windows))
end
