Extension { #name : #GTRunToSelectionDebugAction }

{ #category : #'*PharoSettingsUpTo8' }
GTRunToSelectionDebugAction class >> gtStackDebuggingActionFor: aDebugger [
	<gtStackDebuggingAction>
	<gtCustomDebuggingAction>
	
	^ (self forDebugger: aDebugger)
		icon: (Smalltalk ui icons iconNamed: #bottom)
]
