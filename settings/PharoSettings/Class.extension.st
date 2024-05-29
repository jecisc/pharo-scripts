Extension { #name : 'Class' }

{ #category : '*PharoSettings' }
Class >> altDuplicateClassWithNewName: args [
	| copysName class aSymbol |
	aSymbol := args first.
	copysName := aSymbol asSymbol.
	copysName = self name
		ifTrue: [ ^ self ].
	(self environment includesKey: copysName)
		ifTrue: [ ^ self error: copysName , ' already exists' ].

	class := self classInstaller make: [ :builder |
		builder
			fillFor: self;
			name: copysName].

	class copyAllMethodsFrom: self.
	class class copyAllMethodsFrom: self class.
	class comment: self comment.
	^ class
]
