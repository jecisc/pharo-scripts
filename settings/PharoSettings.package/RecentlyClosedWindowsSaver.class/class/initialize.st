class initialization
initialize
	SessionManager default registerUserClassNamed: self name.
	self startUp: true.
	self setCalypsoMetaLink