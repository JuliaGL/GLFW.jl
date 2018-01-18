# Size of callback vector to create during Window construction
const _window_callbacks_len = Ref(0)

_window_callbacks = Dict{Window, Vector{Function}}()

macro callback(ex)
	ref = gensym()
	declare_ref = :($ref = Ref{Function}(undef))
	ref = :($ref[])

	# Decompose expression
	warp = ex.head == :->
	name_with_params = warp ? ex.args[1] : ex  # Foo(x::T1, y::T2, etc)
	name = string(name_with_params.args[1])    # Foo
	params = name_with_params.args[2:end]      #    (x::T1, y::T2, etc)
	transformed_args = if warp
		ex.args[2].args[2].args                # Everything after ->
	else
		map(paramname, params)                 #    (x,     y,     etc)
	end

	esc(quote
		$declare_ref
		$(callbackexpr(name, params, ref, transformed_args=transformed_args))
	end)
end

macro windowcallback(ex)
	_window_callbacks_len[] += 1
	idx = _window_callbacks_len[]
	ref = :(_window_callbacks[window][$idx])

	# Decompose expression
	warp = ex.head == :->
	name_with_params = warp ? ex.args[1] : ex  # Foo(x::T1, y::T2, etc)
	name = string(name_with_params.args[1])    # Foo
	params = name_with_params.args[2:end]      #    (x::T1, y::T2, etc)
	transformed_args = if warp
		ex.args[2].args[2].args                # Everything after ->
	else
		map(paramname, params)                 #    (x,     y,     etc)
	end

	esc(callbackexpr(name, params, ref, setter_params=[:(window::Window)], transformed_args=transformed_args))
end

function callbackexpr(
	name,
	callback_params,
	callback_var_ex;
	setter_params=[],
	transformed_args=map(paramname, callback_params),
)
	# Construct function names
	setter = Symbol("Set", name, "Callback")          # SetFooCallback
	libsetter = Expr(:quote, Symbol("glfw", setter))  # glfwSetFooCallback
	wrapper = Symbol('_', name, "CallbackWrapper")    # _FooCallbackWrapper

	# Separate names and types of parameters
	callback_param_types = Expr(:curly, :Tuple, map(paramtype, callback_params)...)
	setter_param_names = map(paramname, setter_params)
	setter_param_types = map(paramtype, setter_params)

	quote
		# Set the callback function
		function $setter($(setter_param_names...), callback::Function)
			old_callback = $callback_var_ex
			$callback_var_ex = callback # Prevent Julia function from being garbage-collected
			cfunptr = cfunction($wrapper, Cvoid, $callback_param_types)
			old_cfunptr = ccall( ($libsetter, lib), Ptr{Cvoid}, ($(setter_param_types...), Ptr{Cvoid}), $(setter_param_names...), cfunptr)
			return old_cfunptr == C_NULL ? nothing : old_callback
		end

		# Unset the callback function
		function $setter($(setter_param_names...), ::Nothing)
			old_cfunptr = ccall( ($libsetter, lib), Ptr{Cvoid}, ($(setter_param_types...), Ptr{Cvoid}), $(setter_param_names...), C_NULL)
			old_callback = $callback_var_ex
			$callback_var_ex = undef # Allow former callback function to be garbage-collected
			return old_cfunptr == C_NULL ? nothing : old_callback
		end

		# Julia callback wrapper that can be passed to `cfunction`
		$wrapper($(callback_params...)) = ($callback_var_ex($(transformed_args...)); return nothing)
	end
end

# Helper functions for the callback macro
paramname(ex) = ex.args[1]
paramtype(ex) = ex.args[2]
notnothing(a) = a != nothing
undef(any...) = throw(UndefRefError())
