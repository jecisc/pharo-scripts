Extension { #name : #StepThroughDebugAction }

{ #category : #'*PharoSettingsUpTo8' }
StepThroughDebugAction classSide >> gtCustomStackDebuggingActionFor: aDebugger [
	<gtCustomDebuggingAction>
	
	^ self gtStackDebuggingActionFor: aDebugger
]
