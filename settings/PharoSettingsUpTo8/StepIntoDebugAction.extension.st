Extension { #name : #StepIntoDebugAction }

{ #category : #'*PharoSettingsUpTo8' }
StepIntoDebugAction classSide >> gtCustomStackDebuggingActionFor: aDebugger [
	<gtCustomDebuggingAction>
	
	^ self gtStackDebuggingActionFor: aDebugger
]
