Extension { #name : 'AbstractFileReference' }

{ #category : '*PharoSettings' }
AbstractFileReference >> openInVSCode [
	"This is specific for MacOS. I'll add a version for other OS if I need it later."

	| cmd |
	cmd := 'open -a "Visual Studio Code" "' , self fullName , '"'.
	LibC runCommand: cmd
]
