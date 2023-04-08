Extension { #name : #StepThroughDebugAction }

{ #category : #'*PharoSettingsUpTo8' }
StepThroughDebugAction class >> gtCustomStackDebuggingActionFor: aDebugger [
	<gtCustomDebuggingAction>
	
	^ self gtStackDebuggingActionFor: aDebugger
]
