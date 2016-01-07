# Generate functions for wrapping and setting a callback
macro callback(ex)
	transform = ex.head == :->
	def = transform ? ex.args[1] : ex                  # Foo(x::T1, y::T2, etc)
	name = string(def.args[1], "Callback")             # FooCallback
	args = def.args[2:end]                             # (x::T1, y::T2, etc)
	values = transform ? ex.args[2].args[2].args : map(argname, args)  # (x, y, etc) or whatever came after the ->

	setter = symbol("Set", name)                       # SetFooCallback
	libsetter = Expr(:quote, symbol("glfw", setter))   # glfwSetFooCallback
	wrapper = gensym(string(name, "Wrapper"))          # FooCallbackWrapper

	window_arg = filter(iswindow, args)                # :(window::Window)
	window_value = map(argname, window_arg)            # :window
	handle_type = map(_ -> :WindowHandle, window_arg)  # :WindowHandle

	wrapper_args = map(win2handle, args)
	wrapper_types = Expr(:tuple, map(argtype, wrapper_args)...)
	window_lookup = map(x -> :($x = Base.cconvert(Window, $(win2handle(x)));), window_value)

	if isempty(window_arg)
		callback_ref = gensym(name)
		declare_callback_ref = :($callback_ref = Ref{Function}())
		callback_ref = :($callback_ref[])
	else
		global _window_callbacks_len += 1
		idx = _window_callbacks_len
		callback_ref = :($(window_value[1]).callbacks[$idx])
		declare_callback_ref = nothing
	end

	ex = quote
		$declare_callback_ref

		# Set the callback function
		function $setter($(window_arg...), callback::Function)
			$callback_ref = callback # Prevent Julia function from being garbage-collected
			cfunptr = cfunction($wrapper, Void, $wrapper_types)
			ccall( ($libsetter, lib), Void, ($(handle_type...), Ptr{Void}), $(window_value...), cfunptr)
		end

		# Unset the callback function
		function $setter($(window_arg...), ::Void)
			ccall( ($libsetter, lib), Void, ($(handle_type...), Ptr{Void}), $(window_value...), C_NULL)
			$callback_ref = undef # Allow former callback function to be garbage-collected
			return nothing
		end

		# Julia callback wrapper that can be passed to `cfunction`
		$wrapper($(wrapper_args...)) = ($(window_lookup...); $callback_ref($(values...)); return nothing)
	end
	esc(ex)
end

# Helper functions for the callback macro
argname(ex) = ex.args[1]
argtype(ex) = ex.args[2]
iswindow(ex) = argtype(ex) == :Window
win2handle(name::Symbol) = symbol(name, "_handle")
win2handle(ex) = iswindow(ex) ? :($(win2handle(argname(ex)))::WindowHandle) : ex
undef(any...) = throw(UndefRefError())

# Size of vector to create during Window construction
_window_callbacks_len = 0
