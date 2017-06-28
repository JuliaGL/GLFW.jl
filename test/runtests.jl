travis = get(ENV, "TRAVIS", "") == "true"

import GLFW

if !travis
	include("windowclose.jl")
end
