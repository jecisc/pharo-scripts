Extension { #name : #ResumeDebugAction }

{ #category : #'*PharoSettingsUpTo8' }
ResumeDebugAction class >> gtCustomStackDebuggingActionFor: aDebugger [
	<gtCustomDebuggingAction>
	
	^ self gtStackDebuggingActionFor: aDebugger
]
