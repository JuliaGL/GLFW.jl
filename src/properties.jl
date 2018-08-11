function genproperties(typ, props)
	props = [(name=p[1], getter=p[2], setter=p[3]) for p in props]
	getbranch(prop) = quote
		if name == $(QuoteNode(prop.name))
			return $(prop.getter)(value)
		end
	end
	setbranch(prop) = quote
		if name == $(QuoteNode(prop.name))
			return $(prop.setter)(value, x)
		end
	end
	quote
		Base.propertynames(::$typ) =
			(fieldnames($typ)..., $(map(p -> QuoteNode(p.name), props)...))

		function Base.getproperty(value::$typ, name::Symbol)
			$(map(getbranch, props)...)
			getfield(value, name)
		end

		function Base.setproperty!(value::$typ, name::Symbol, x)
			$(map(setbranch, props)...)
			setfield!(value, name, x)
		end
	end
end

readonly(_1, _2) = error("property is read-only")
writeonly(_) = error("property is write-only")

eval(genproperties(Monitor, [
	# TODO for GLFW 3.3: contentscale is GetMonitorContentScale
	(:isprimary, m -> GetPrimaryMonitor() == m, readonly),
	(:name, GetMonitorName, readonly),
	(:physicalsize, GetMonitorPhysicalSize, readonly),
	(:position, GetMonitorPos, readonly),
	(:supported_videomodes, GetVideoModes, readonly),
	(:videomode, GetVideoMode, readonly),
]))

eval(genproperties(Window, [
	(:focused, w -> Bool(GetWindowAttrib(w, FOCUSED)), readonly),
	(:maximized, w -> Bool(GetWindowAttrib(w, MAXIMIZED)), (w, yes) -> yes ? MaximizeWindow(w) : RestoreWindow(w)),
	(:minimized, w -> Bool(GetWindowAttrib(w, ICONIFIED)), (w, yes) -> yes ? IconifyWindow(w) : RestoreWindow(w)), # FIXME
	(:monitor, GetWindowMonitor, readonly),
	(:position, GetWindowPos, (w, pos) -> SetWindowPos(w, pos...)),
	(:size, GetWindowSize, (w, size) -> SetWindowSize(w, size...)),
	(:title, writeonly, SetWindowTitle),
	(:visible, w -> Bool(GetWindowAttrib(w, VISIBLE)), (w, yes) -> yes ? ShowWindow(w) : HideWindow(w)),
]))
