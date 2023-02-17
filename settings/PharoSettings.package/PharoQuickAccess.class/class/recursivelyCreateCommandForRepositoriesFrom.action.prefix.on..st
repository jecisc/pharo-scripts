world menu
recursivelyCreateCommandForRepositoriesFrom: aFolder action: action prefix: aString on: aBuilder
	self flag: #pharo5.	"When support for P5 will be dropped, use a sort function."
	((self subDirectoriesOf: aFolder) sort: [ :a :b | a basename asLowercase < b basename asLowercase ])
		do: [ :dir |
			(((self subDirectoriesOf: dir)) anySatisfy: [ :e | e basename = '.git' ])
				ifTrue: [ (aBuilder item: (aString , dir basename) asSymbol)
						action: [ self executeBlock: [ action cull: dir ] ];
						iconName: #smallDoIt ]
				ifFalse: [ (aBuilder item: (aString , dir basename) asSymbol)
						iconName: #configNew;
						with: [ self
								recursivelyCreateCommandForRepositoriesFrom: dir
								action: action
								prefix: aString
								on: aBuilder ] ] ]