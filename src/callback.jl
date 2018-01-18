# Size of callback vector to create during Window construction
const _window_callbacks_len = Ref(0)

_window_callbacks = Dict{Window, Vector{Function}}()

macro callback(ex)
	ref = gensym()
	declare_ref = :($ref = Ref{Function}(undef))
	ref = :($ref[])
	esc(quote
		$declare_ref
		$(callback_expr(ex, ref))
	end)
end

macro windowcallback(ex)
	_window_callbacks_len[] += 1
	idx = _window_callbacks_len[]
	ref = :(_window_callbacks[window][$idx])
	esc(callback_expr(ex, ref, :window, :Window))
end

# Generate functions for wrapping and setting a callback
function callback_expr(ex, jl_callback_ref, handle_arg=nothing, handle_type=nothing)
	# Decompose expression
	warp = ex.head == :->
	name_with_params = warp ? ex.args[1] : ex  # Foo(x::T1, y::T2, etc)
	name = string(name_with_params.args[1])    # Foo
	params = name_with_params.args[2:end]      #    (x::T1, y::T2, etc)
	jl_callback_args = if warp
		ex.args[2].args[2].args                # Everything after ->
	else
		map(argname, params)                   #    (x,     y,     etc)
	end
	callback_types = Expr(:curly, :Tuple, map(argtype, params)...)

	# Construct function name symbols
	setter = Symbol("Set", name, "Callback")          # SetFooCallback
	libsetter = Expr(:quote, Symbol("glfw", setter))  # glfwSetFooCallback
	wrapper = Symbol(string('_', name, "Wrapper"))    # _FooCallbackWrapper

	# Convert to iterables that can be splatted into expression
	handle_arg = filter(notnothing, [handle_arg])
	handle_type = filter(notnothing, [handle_type])

	quote
		# Set the callback function
		function $setter($(handle_arg...), callback::Function)
			old_jl_callback = $jl_callback_ref
			$jl_callback_ref = callback # Prevent Julia function from being garbage-collected
			cfunptr = cfunction($wrapper, Cvoid, $callback_types)
			old_cfunptr = ccall( ($libsetter, lib), Ptr{Cvoid}, ($(handle_type...), Ptr{Cvoid}), $(handle_arg...), cfunptr)
			return old_cfunptr == C_NULL ? nothing : old_jl_callback
		end

		# Unset the callback function
		function $setter($(handle_arg...), ::Nothing)
			old_cfunptr = ccall( ($libsetter, lib), Ptr{Cvoid}, ($(handle_type...), Ptr{Cvoid}), $(handle_arg...), C_NULL)
			old_jl_callback = $jl_callback_ref
			$jl_callback_ref = undef # Allow former callback function to be garbage-collected
			return old_cfunptr == C_NULL ? nothing : old_jl_callback
		end

		# Julia callback wrapper that can be passed to `cfunction`
		$wrapper($(params...)) = ($jl_callback_ref($(jl_callback_args...)); return nothing)
	end
end

# Helper functions for the callback macro
argname(ex) = ex.args[1]
argtype(ex) = ex.args[2]
iswindow(ex) = argtype(ex) == :Window
notnothing(a) = a != nothing
undef(any...) = throw(UndefRefError())
