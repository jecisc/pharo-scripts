Extension { #name : #SycMoveMethodsToPackageCommand }

{ #category : #'*PharoSettings7' }
SycMoveMethodsToPackageCommand class >> methodShortcutActivation [
	<classAnnotation>
	^ CmdShortcutActivation by: $p meta , $m meta for: ClyMethod asCalypsoItemContext
]
