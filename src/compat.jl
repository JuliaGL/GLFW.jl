# Shims for using Julia 0.7 constructs in 0.6.

if !isdefined(Base, :Cvoid)
	const Cvoid = Void
end

if !isdefined(Base, :Nothing)
	const Nothing = Void
end

const isapple = if !isdefined(Sys, :isapple)
	is_apple
else
	Sys.isapple
end

const iswindows = if !isdefined(Sys, :iswindows)
	is_windows
else
	Sys.iswindows
end
