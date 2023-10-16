Extension { #name : 'SycMoveMethodsToPackageCommand' }

{ #category : '*PharoSettings' }
SycMoveMethodsToPackageCommand class >> methodShortcutActivation [
	<classAnnotation>
	^ CmdShortcutActivation by: $p meta , $m meta for: ClyMethod asCalypsoItemContext
]
