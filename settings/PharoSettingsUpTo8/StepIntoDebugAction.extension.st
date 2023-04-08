Extension { #name : #StepIntoDebugAction }

{ #category : #'*PharoSettingsUpTo8' }
StepIntoDebugAction class >> gtCustomStackDebuggingActionFor: aDebugger [
	<gtCustomDebuggingAction>
	
	^ self gtStackDebuggingActionFor: aDebugger
]
