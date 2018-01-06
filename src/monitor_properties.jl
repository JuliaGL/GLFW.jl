function Base.getproperty(monitor::Monitor, name::Symbol)
	if name == :name
		GetMonitorName(monitor)
	elseif name == :mode
		GetVideoMode(monitor)
	elseif name == :physical_size
		GetMonitorPhysicalSize(monitor)
	elseif name == :position
		GetMonitorPos(monitor)
	elseif name == :supported_modes
		GetVideoModes(monitor)
	else
		getfield(monitor, name)
	end
end
