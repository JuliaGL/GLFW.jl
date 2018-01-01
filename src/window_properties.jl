function Base.getproperty(window::Window, name::Symbol)
	if name == :focused
		Bool(GetWindowAttrib(window, FOCUSED))
	elseif name == :minimized
		Bool(GetWindowAttrib(window, ICONIFIED))
	elseif name == :monitor
		GetWindowMonitor(window)
	elseif name == :position
		GetWindowPos(window)
	elseif name == :size
		GetWindowSize(window)
	elseif name == :title
		error("title property is write-only")
	elseif name == :visible
		Bool(GetWindowAttrib(window, VISIBLE))
	else
		getfield(window, name)
	end
end

function Base.setproperty!(window::Window, name::Symbol, value)
	if name == :focused
		error("focused property is read-only")
	elseif name == :minimized
		value ? IconifyWindow(window) : RestoreWindow(window)
	elseif name == :monitor
		error("monitor property is read-only; use GLFW.SetWindowMonitor to change it")
	elseif name == :position
		SetWindowPos(window, value...)
	elseif name == :size
		SetWindowSize(window, value...)
	elseif name == :title
		SetWindowTitle(window, value)
	elseif name == :visible
		value ? ShowWindow(window) : HideWindow(window)
	else
		setfield!(window, name, value)
	end
end
