function Base.getproperty(monitor::Monitor, name::Symbol)
	# TODO for GLFW 3.3: contentscale is GetMonitorContentScale
	if name == :isprimary
		GetPrimaryMonitor() == monitor
	elseif name == :name
		GetMonitorName(monitor)
	elseif name == :physicalsize
		GetMonitorPhysicalSize(monitor)
	elseif name == :position
		GetMonitorPos(monitor)
	elseif name == :supported_videomodes
		GetVideoModes(monitor)
	elseif name == :videomode
		GetVideoMode(monitor)
	else
		getfield(monitor, name)
	end
end

Base.setproperty!(::Monitor, ::Symbol, _) = error("type Monitor properties are read-only")

Base.propertynames(::Monitor) = (
	fieldnames(Monitor)...,
	:isprimary,
	:name,
	:physicalsize,
	:position,
	:supported_videomodes,
	:videomode,
)

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

Base.propertynames(::Window) = (
	fieldnames(Window)...,
	:focused,
	:minimized,
	:monitor,
	:position,
	:size,
	:title,
	:visible,
)
