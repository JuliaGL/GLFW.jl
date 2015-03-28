
function generate_callback(f::Function, argtypes)
	isgeneric(f) && return cfunction(f, Void, argtypes)
	names 	= ntuple(i->symbol("i$i"), length(argtypes))
	args 	= ntuple(i->:($(names[i])::$(argtypes[i])), length(argtypes))
	funsym 	= gensym()
	func 	= @eval begin
		$funsym($(args...)) = (f($(names...)); nothing)
	end
	cfunction(func, Void, argtypes)
end
# generate methods for wrapping and setting a callback
macro Set(callback)

	wrapperfunc = callback.args[1]                           # FooCallback
	setfunc  	= symbol(string("Set", wrapperfunc))            # SetFooCallback
	setcfunc 	= Expr(:quote, symbol(string("glfw", setfunc)))	# :glfwSetFooCallback, workaround for not being able to interpolate symbol

	argnames 			= map(a -> a.args[1], callback.args[2:end])
	argtypes 			= map(a -> a.args[2], callback.args[2:end])
	iswindowcallback 	= isdefined(:Window) && :Window in argtypes # is first argument of type windows?
	argtypes 			= Expr(:tuple, argtypes...) # make tuple 

	callback_args_glfw 	= [(:funcptr, Ptr{Void})]
	callback_args_set 	= [(:callback, Function)]
	setfun_cfun_args 	= [:cfun]

	if iswindowcallback
		unshift!(callback_args_glfw, (:window, Window)) # insert windows argument in front
		unshift!(callback_args_set,  (:window, Window))
		unshift!(setfun_cfun_args,    :window)
	end

	callback_args_glfw_name 	  = map(first, callback_args_glfw)
	callback_args_glfw_type 	  = map(last, callback_args_glfw)
	callback_args_glfw_name_typed = [:($arname::$argtype) for (arname, argtype) in callback_args_glfw]

	callback_args_set_name_typed  = [:($arname::$argtype) for (arname, argtype) in callback_args_set]

	expr = quote
		function $setfunc($(callback_args_glfw_name_typed...))
			ccall(($setcfunc, lib), Void, ($(callback_args_glfw_type...),), $(callback_args_glfw_name...))
		end
		function $setfunc($(callback_args_set_name_typed...))
			if isgeneric(callback) && !method_exists(callback, $argtypes)
				throw(MethodError(callback, $argtypes))
			end
			cfun = generate_callback(callback, $argtypes)
			$setfunc($(setfun_cfun_args...))
		end
	end
	return esc(expr)
end
