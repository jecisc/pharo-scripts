Extension { #name : #GTRunToSelectionDebugAction }

{ #category : #'*PharoSettingsUpTo8' }
GTRunToSelectionDebugAction classSide >> gtStackDebuggingActionFor: aDebugger [
	<gtStackDebuggingAction>
	<gtCustomDebuggingAction>
	
	^ (self forDebugger: aDebugger)
		icon: (Smalltalk ui icons iconNamed: #bottom)
]
