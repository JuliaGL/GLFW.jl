# generate methods for wrapping and setting a callback
macro callback(ex)
	signature = ex.head == :call ? ex : ex.args[1]
	name = signature.args[1]
	ccall_args = signature.args[2:end]
	ccall_arg_names = map(a -> a.args[1], ccall_args)
	ccall_arg_types = Expr(:tuple, map(a -> a.args[2], ccall_args)...)

	setfunc = symbol("Set", name, "Callback")
	libfunc = Expr(:quote, symbol("glfw", setfunc))
	wrapfunc = symbol(name, "CallbackWrapper") # wrapper function that meets cfunction requirements
	jcbfunc = gensym(string(name, "Callback")) # Julia callback function called by wrapper function
	jcbfunc_arg_values = ex.head == :-> ? ex.args[2].args[2].args : ccall_arg_names

	window_callback = length(ccall_arg_types.args) >= 1 && ccall_arg_types.args[1] == :Window
	win_arg = window_callback ? (ccall_args[1],) : ()
	win_name = window_callback ? (ccall_arg_names[1],) : ()
	win_type = window_callback ? (ccall_arg_types.args[1],) : ()

	ex = quote
		function $setfunc($(win_arg...), callback::Function)
			cfun = (isgeneric(callback) && method_exists(callback, $ccall_arg_types)) ? callback : $wrapfunc
			$setfunc($(win_name...), cfunction(cfun, Void, $ccall_arg_types), callback)
		end

		function $setfunc($(win_arg...), cfunptr::Ptr{Void}, jfunref=nothing)
			global $jcbfunc = jfunref # prevent Julia function from being garbage-collected
			ccall( ($libfunc, lib), Void, ($(win_type...), Ptr{Void}), $(win_name...), cfunptr)
		end

		$setfunc($(win_arg...), ::Void) = $setfunc($(win_name...), C_NULL)

		$wrapfunc($(ccall_args...)) = ($jcbfunc($(jcbfunc_arg_values...)); return nothing)
	end
	esc(ex)
end
