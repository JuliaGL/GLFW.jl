function GetVersion()
	major, minor, rev = Cint[0], Cint[0], Cint[0]
	ccall( (:glfwGetVersion, lib), Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), major, minor, rev)
	(major[1], minor[1], rev[1])
end

function Init()
	ret = ccall( (:glfwInit, lib), Cint, ())
	if ret != 1
		error("initialization failed")
	end
end

function Terminate()
	ccall( (:glfwTerminate, lib), Void, ())
end
