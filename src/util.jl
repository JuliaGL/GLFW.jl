typealias Callback Union(Function, Nothing)

# global callback function references
const _callbacks = Array(Callback, 0)

# generate methods for wrapping and setting a callback
macro Set(callback)

	wrapperfunc = callback.args[1]                           # FooCallback
	setfunc  = symbol(string("Set", wrapperfunc))            # SetFooCallback
	setcfunc = Expr(:quote, symbol(string("glfw", setfunc))) # :glfwSetFooCallback

	argnames = map(a -> a.args[1], callback.args[2:end])
	argtypes = Expr(:tuple, map(a -> a.args[2], callback.args[2:end])...)

	iswindowcallback = isdefined(:Window) && Window in eval(argtypes)

	# grow callback function reference collection
	if iswindowcallback
		idx = length(WindowData("").callbacks) + 1
		@eval WindowData(title::String) = WindowData(title, Array(Callback, $idx))
		juliafunc = :(_windows[window].callbacks[$idx])
	else
		idx = length(_callbacks) + 1
		push!(_callbacks, nothing)
		juliafunc = :(_callbacks[$idx])
	end

	# methods for window-specific callbacks
	ex = iswindowcallback ? quote

		# ccall wrapper
		function $setfunc(window::Window, funcptr::Ptr{Void}, objref=nothing)
			$juliafunc = objref
			ccall( ($setcfunc, lib), Void, (Window, Ptr{Void}), window, funcptr)
		end

		# set callback
		function $setfunc(window::Window, callback::Function)
			if isgeneric(callback) && !method_exists(callback, $argtypes)
				throw(MethodError(callback, $argtypes))
			end
			try
				$setfunc(window, cfunction(callback, Void, $argtypes))
			catch
				$setfunc(window, cfunction($wrapperfunc, Void, $argtypes), callback)
			end
		end

		# wraps callbacks that can't be cfunction'd
		$callback = begin
			try
				$juliafunc($(argnames...))
			catch e
				try # without window arg
					$juliafunc($(argnames[2:end]...))
				catch
					rethrow(e)
				end
			end
			return nothing
		end

		# unset callback
		$setfunc(window::Window, ::Nothing) = $setfunc(window, C_NULL)

	# methods for global callbacks
	end : quote

		# ccall wrapper
		function $setfunc(funcptr::Ptr{Void}, objref=nothing)
			$juliafunc = objref
			ccall( ($setcfunc, lib), Void, (Ptr{Void},), funcptr)
		end

		# set callback
		function $setfunc(callback::Function)
			if isgeneric(callback) && !method_exists(callback, $argtypes)
				throw(MethodError(callback, $argtypes))
			end
			try
				$setfunc(cfunction(callback, Void, $argtypes))
			catch
				$setfunc(cfunction($wrapperfunc, Void, $argtypes), callback)
			end
		end

		# wraps callbacks that can't be cfunction'd
		$callback = begin
			$juliafunc($(argnames...))
			return nothing
		end

		# unset callback
		$setfunc(::Nothing) = $setfunc(C_NULL)

	end
	esc(ex)
end

# builds prior to May 14, 2014 (0.3.0-prerelease) don't support Integer
if !method_exists(pointer_to_array, (Any, Integer))
	Base.pointer_to_array(p, d::Integer) = pointer_to_array(p, int(d))
end
