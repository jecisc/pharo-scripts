Extension { #name : #StepOverDebugAction }

{ #category : #'*PharoSettingsUpTo8' }
StepOverDebugAction class >> gtCustomStackDebuggingActionFor: aDebugger [
	<gtCustomDebuggingAction>
	
	^ self gtStackDebuggingActionFor: aDebugger
]
