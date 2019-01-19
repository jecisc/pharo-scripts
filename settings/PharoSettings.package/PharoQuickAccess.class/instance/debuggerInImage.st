seaside
debuggerInImage
	<name: #'Enable in image debugger'>
	self class environment
		at: #WAApplication
		ifPresent: [ :class | class allInstancesDo: [ :app | app exceptionHandler: (Smalltalk at: #WADebugErrorHandler) ] ]
		ifAbsent: [ self error: 'Seaside dev not loaded' ]