import GLFW

travis = haskey(ENV, "TRAVIS") && ENV["TRAVIS"] == "true"

try
	GLFW.Init()
catch e
	if travis && contains(e.msg, "/dev/input: No such file or directory")
		warn(e.msg)
	else
		rethrow()
	end
end
GLFW.Terminate()
