# Generate code for a global callback
macro callback(ex)
	ref = gensym()
	esc(quote
		const $ref = Ref{Function}(undef)
		$(callbackcode(extractargs(ex)..., :($ref[])))
	end)
end

# Number of callback functions per window
const _window_callback_num = Ref(0)

# Generate code for a window-specific callback
macro windowcallback(ex)
	_window_callback_num[] += 1
	i = _window_callback_num[]
	ref = :(callbacks(window)[$i])
	esc(callbackcode(extractargs(ex)..., ref, [:(window::Window)]))
end

# Generate expression with functions for [un]setting a callback
function callbackcode(
	name,
	callback_params,  # Signature of the C-compatible wrapper function
	callback_args,    # How the wrapper passes arguments to the callback
	callback_var,     # Variable that stores reference to callback function
	setter_params=[], # Initial parameter(s) to setter (e.g. window handle)
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
			old_callback = $callback_var
			$callback_var = callback  # Prevent callback function from being garbage-collected
			cfunptr = cfunction($wrapper, Cvoid, $callback_param_types)
			old_cfunptr = ccall( ($libsetter, lib), Ptr{Cvoid}, ($(setter_param_types...), Ptr{Cvoid}), $(setter_param_names...), cfunptr)
			return old_cfunptr == C_NULL ? nothing : old_callback
		end

		# Unset the callback function
		function $setter($(setter_param_names...), ::Nothing)
			old_cfunptr = ccall( ($libsetter, lib), Ptr{Cvoid}, ($(setter_param_types...), Ptr{Cvoid}), $(setter_param_names...), C_NULL)
			old_callback = $callback_var
			$callback_var = undef  # Allow former callback function to be garbage-collected
			return old_cfunptr == C_NULL ? nothing : old_callback
		end

		# Callback wrapper that can be passed to `cfunction`
		$wrapper($(callback_params...)) = ($callback_var($(callback_args...)); return nothing)
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
