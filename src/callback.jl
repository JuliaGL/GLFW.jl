# Generate code for a global callback
macro callback(ex)
	var_sym = gensym()
	var_ex = :($var_sym[])
	declare_var = :($var_sym = Ref{Function}(undef))
	code = callbackcode(extractargs(ex)..., var_ex)
	esc(quote
		$declare_var
		$code
	end)
end

# Number of callback functions per window
const _window_callback_num = Ref(0)

# Generate code for a window-specific callback
macro windowcallback(ex)
	_window_callback_num[] += 1
	idx = _window_callback_num[]
	var_ex = :(callbacks(window)[$idx])
	code = callbackcode(extractargs(ex)..., var_ex, [:(window::Window)])
	esc(code)
end

function callbackcode(
	name,
	callback_params,
	callback_args,
	callback_var_ex,
	setter_params=[],
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
		$wrapper($(callback_params...)) = ($callback_var_ex($(callback_args...)); return nothing)
	end
end

function extractargs(ex)
	before, after = arrowsplit(ex)
	name = string(before.args[1])
	params = before.args[2:end]
	args = isa(after, Expr) ? after.args : map(paramname, params)
	name, params, args
end

function arrowsplit(ex)
	if ex.head == :->
		ex.args[1], ex.args[2].args[2]
	else
		ex, nothing
	end
end

paramname(param_ex) = param_ex.args[1]
paramtype(param_ex) = param_ex.args[2]
undef(any...) = throw(UndefRefError())
