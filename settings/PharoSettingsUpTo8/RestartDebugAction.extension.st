Extension { #name : #RestartDebugAction }

{ #category : #'*PharoSettingsUpTo8' }
RestartDebugAction classSide >> gtCustomStackDebuggingActionFor: aDebugger [
	<gtCustomDebuggingAction>
	
	^ self gtStackDebuggingActionFor: aDebugger
]
