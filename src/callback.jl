const Callback = Union{Function, Nothing}

# Generate code for a global callback
macro callback(ex)
	ref = gensym()
	esc(quote
		const $ref = Ref{Callback}(nothing)
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
	callback_ref,     # Persisted reference to callback function
	setter_params=[], # Initial parameter(s) to setter (e.g. window handle)
)
	# Construct function names
	setter = Symbol("Set", name, "Callback")          # SetFooCallback
	libsetter = Expr(:quote, Symbol("glfw", setter))  # glfwSetFooCallback
	wrapper = Symbol('_', name, "CallbackWrapper")    # _FooCallbackWrapper

	# Separate names and types of parameters
	callback_param_types = Expr(:tuple, map(paramtype, callback_params)...)
	setter_param_names = map(paramname, setter_params)
	setter_param_types = map(paramtype, setter_params)

	# All glfwSetFooCallbacks currently in use are restricted to the main thread.
	# For reference the current ones are: glfwSetKeyCallback, glfwSetCharCallback, glfwSetCharModsCallback, glfwSetMouseButtonCallback, glfwSetCursorPosCallback, glfwSetCursorEnterCallback, glfwSetScrollCallback, glfwSetDropCallback, glfwSetWindowPosCallback, glfwSetWindowSizeCallback, glfwSetWindowCloseCallback, glfwSetWindowRefreshCallback, glfwSetWindowFocusCallback, glfwSetWindowIconifyCallback, glfwSetWindowMaximizeCallback, glfwSetFramebufferSizeCallback, glfwSetWindowContentScaleCallback, glfwSetJoystickCallback, glfwSetErrorCallback, glfwSetMonitorCallback

	quote
		# Callback wrapper that can be passed to `cfunction`
		$wrapper($(callback_params...)) = ($callback_ref($(callback_args...)); return nothing)

		# Set the callback function
		function $setter($(setter_param_names...), callback::Function)
			require_main_thread()
			old_callback = $callback_ref
			$callback_ref = callback  # Prevent callback function from being garbage-collected
			cfunptr = @cfunction($wrapper, Cvoid, $callback_param_types)
			ccall(($libsetter, libglfw), Ptr{Cvoid}, ($(setter_param_types...), Ptr{Cvoid}), $(setter_param_names...), cfunptr)
			return old_callback
		end

		# Unset the callback function
		function $setter($(setter_param_names...), ::Nothing)
			require_main_thread()
			ccall(($libsetter, libglfw), Ptr{Cvoid}, ($(setter_param_types...), Ptr{Cvoid}), $(setter_param_names...), C_NULL)
			old_callback = $callback_ref
			$callback_ref = nothing  # Allow former callback function to be garbage-collected
			return old_callback
		end
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
