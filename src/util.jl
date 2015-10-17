# generate methods for wrapping and setting a callback
macro callback(ex)
	signature = ex.head == :call ? ex : ex.args[1]

	name = string(signature.args[1], "Callback")
	callback = gensym(name)
	setter = symbol("Set", name)
	libsetter = Expr(:quote, symbol("glfw", setter))
	wrapper = symbol(name, "Wrapper")

	ccall_args = signature.args[2:end]
	ccall_arg_names = map(a -> a.args[1], ccall_args)
	ccall_arg_types = Expr(:tuple, map(a -> a.args[2], ccall_args)...)
	callback_arg_values = ex.head == :-> ? ex.args[2].args[2].args : ccall_arg_names

	is_window_callback = length(ccall_arg_types.args) >= 1 && ccall_arg_types.args[1] == :Window
	win_arg = is_window_callback ? (ccall_args[1],) : ()
	win_name = is_window_callback ? (ccall_arg_names[1],) : ()
	win_type = is_window_callback ? (ccall_arg_types.args[1],) : ()

	ex = quote
		# Set the callback to a Julia function
		function $setter($(win_arg...), callback::Function)
			cfun = (isgeneric(callback) && method_exists(callback, $ccall_arg_types)) ? callback : $wrapper
			$setter($(win_name...), cfunction(cfun, Void, $ccall_arg_types), callback)
		end

		# Set the callback to a C function pointer
		function $setter($(win_arg...), cfunptr::Ptr{Void}, jlfunref=nothing)
			global $callback = jlfunref # prevent callback from being garbage-collected
			ccall( ($libsetter, lib), Void, ($(win_type...), Ptr{Void}), $(win_name...), cfunptr)
		end

		# Remove the current callback
		$setter($(win_arg...), ::Void) = $setter($(win_name...), C_NULL)

		# Julia callback wrapper that can be passed to `cfunction`
		$wrapper($(ccall_args...)) = ($callback($(callback_arg_values...)); return nothing)
	end
	esc(ex)
end
