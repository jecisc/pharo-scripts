Extension { #name : #StepOverDebugAction }

{ #category : #'*PharoSettingsUpTo8' }
StepOverDebugAction classSide >> gtCustomStackDebuggingActionFor: aDebugger [
	<gtCustomDebuggingAction>
	
	^ self gtStackDebuggingActionFor: aDebugger
]
