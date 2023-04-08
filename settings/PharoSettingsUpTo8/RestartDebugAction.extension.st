Extension { #name : #RestartDebugAction }

{ #category : #'*PharoSettingsUpTo8' }
RestartDebugAction class >> gtCustomStackDebuggingActionFor: aDebugger [
	<gtCustomDebuggingAction>
	
	^ self gtStackDebuggingActionFor: aDebugger
]
