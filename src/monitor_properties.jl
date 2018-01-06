function Base.getproperty(monitor::Monitor, name::Symbol)
	if name == :name
		GetMonitorName(monitor)
	elseif name == :isprimary
		GetPrimaryMonitor() == monitor
	elseif name == :physicalsize
		GetMonitorPhysicalSize(monitor)
	elseif name == :position
		GetMonitorPos(monitor)
	elseif name == :videomode
		GetVideoMode(monitor)
	elseif name == :videomodes
		GetVideoModes(monitor)
	else
		getfield(monitor, name)
	end
end
