# generate methods for setting a callback
macro SetCallback(event, returns, args)
	func = symbol(string("Set", event, "Callback"))
	cfunc = Expr(:quote, symbol(string("glfw", func)))
	methods = isdefined(:Window) && Window in eval(args) ? quote
		$func(window::Window, callback::Ptr{Void}) = ccall( ($cfunc, lib), Void, (Window, Ptr{Void}), window, callback)
		$func(window::Window, callback::Function) = $func(window, cfunction(callback, $returns, $args))
		$func(window::Window, ::Nothing) = $func(window, C_NULL)
	end : quote
		$func(callback::Ptr{Void}) = ccall( ($cfunc, lib), Void, (Ptr{Void},), callback)
		$func(callback::Function) = $func(cfunction(callback, $returns, $args))
		$func(::Nothing) = $func(C_NULL)
	end
	esc(methods)
end

# https://github.com/JuliaLang/julia/pull/4497
Base.pointer_to_array(p, d::Integer) = pointer_to_array(p, int(d))
