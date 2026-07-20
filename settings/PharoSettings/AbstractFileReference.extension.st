Extension { #name : 'AbstractFileReference' }

{ #category : '*PharoSettings' }
AbstractFileReference >> openInVSCode [
	"This is specific for MacOS. I'll add a version for other OS if I need it later."

	LibC runCommand: 'open -a "Visual Studio Code" "' , self fullName , '"'
]
