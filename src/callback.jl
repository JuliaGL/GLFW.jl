# Size of callback vector to create during Window construction
const _window_callbacks_len = Ref(0)

_window_callbacks = Dict{Window, Vector{Function}}()

# Generate functions for wrapping and setting a callback
macro callback(ex)
	transform = ex.head == :->
	def = transform ? ex.args[1] : ex                  # Foo(x::T1, y::T2, etc)
	name = string(def.args[1], "Callback")             # FooCallback
	args = def.args[2:end]                             # (x::T1, y::T2, etc)
	values = transform ? ex.args[2].args[2].args : map(argname, args)  # (x, y, etc) or whatever came after the ->

	setter = Symbol("Set", name)                       # SetFooCallback
	libsetter = Expr(:quote, Symbol("glfw", setter))   # glfwSetFooCallback
	wrapper = Symbol(string('_', name, "Wrapper"))     # _FooCallbackWrapper

	window_arg = filter(iswindow, args)                # :(window::Window)
	window_value = map(argname, window_arg)            # :window
	handle_type = map(x -> :Window, window_arg)        # :Window

	wrapper_args = args
	wrapper_types = Expr(:curly, :Tuple, map(argtype, wrapper_args)...)

	if isempty(window_arg)
		callback_ref = gensym(name)
		declare_callback_ref = :($callback_ref = Ref{Function}(undef))
		callback_ref = :($callback_ref[])
	else
		_window_callbacks_len[] += 1
		idx = _window_callbacks_len[]
		callback_ref = :(_window_callbacks[window][$idx])
		declare_callback_ref = nothing
	end

	ex = quote
		$declare_callback_ref

		# Set the callback function
		function $setter($(window_arg...), callback::Function)
			old_callback = $callback_ref
			$callback_ref = callback # Prevent Julia function from being garbage-collected
			cfunptr = cfunction($wrapper, Cvoid, $wrapper_types)
			old_cfunptr = ccall( ($libsetter, lib), Ptr{Cvoid}, ($(handle_type...), Ptr{Cvoid}), $(window_value...), cfunptr)
			return old_cfunptr == C_NULL ? nothing : old_callback
		end

		# Unset the callback function
		function $setter($(window_arg...), ::Nothing)
			old_cfunptr = ccall( ($libsetter, lib), Ptr{Cvoid}, ($(handle_type...), Ptr{Cvoid}), $(window_value...), C_NULL)
			old_callback = $callback_ref
			$callback_ref = undef # Allow former callback function to be garbage-collected
			return old_cfunptr == C_NULL ? nothing : old_callback
		end

		# Julia callback wrapper that can be passed to `cfunction`
		$wrapper($(wrapper_args...)) = ($callback_ref($(values...)); return nothing)
	end
	esc(ex)
end

# Helper functions for the callback macro
argname(ex) = ex.args[1]
argtype(ex) = ex.args[2]
iswindow(ex) = argtype(ex) == :Window
undef(any...) = throw(UndefRefError())
