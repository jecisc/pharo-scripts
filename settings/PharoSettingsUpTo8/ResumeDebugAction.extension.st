Extension { #name : #ResumeDebugAction }

{ #category : #'*PharoSettingsUpTo8' }
ResumeDebugAction classSide >> gtCustomStackDebuggingActionFor: aDebugger [
	<gtCustomDebuggingAction>
	
	^ self gtStackDebuggingActionFor: aDebugger
]
