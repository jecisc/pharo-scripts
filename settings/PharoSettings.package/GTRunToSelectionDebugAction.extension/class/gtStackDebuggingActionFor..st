*PharoSettings
gtStackDebuggingActionFor: aDebugger
	<gtStackDebuggingAction>
	<gtCustomDebuggingAction>
	
	^ (self forDebugger: aDebugger)
		icon: (Smalltalk ui icons iconNamed: #bottom)