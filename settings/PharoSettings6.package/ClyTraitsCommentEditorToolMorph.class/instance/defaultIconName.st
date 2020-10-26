initialization
defaultIconName
	^ (editingClass traitComposition allTraits anySatisfy: #hasComment)
		ifTrue: [ #commentsIcon ]
		ifFalse: [ #uncommentedClass ]