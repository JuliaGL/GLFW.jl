function GetVersionString()
	val = ccall( (:glfwGetVersionString, lib), Ptr{Uint8}, ())
	bytestring(val)
end

