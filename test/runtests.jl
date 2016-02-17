travis = get(ENV, "TRAVIS", "") == "true"

try
	# try...catch introduces a new scope, so we need to eval the import
	# into the Main module scope.
	eval(Main, :(import GLFW))
        include("windowclose.jl")
catch e
	if travis && contains(e.msg, "/dev/input: No such file or directory")
		warn(e.msg)
	else
		rethrow()
	end
end
