world menu
recursivelyCreateCommandForRepositoriesFrom: aFolder action: action prefix: aString on: aBuilder
	aFolder directories
		do: [ :dir | 
			(dir directories anySatisfy: [ :e | e basename = '.git' ])
				ifTrue: [ (aBuilder item: (aString , dir basename) asSymbol)
						action: [ self executeBlock: [ action cull: dir ] ];
						iconName: #smallDoIt ]
				ifFalse: [ (aBuilder item: (aString , dir basename) asSymbol)
						iconName: #configNew;
						with: [ self recursivelyCreateCommandForRepositoriesFrom: dir action: action prefix: aString on: aBuilder ] ] ]