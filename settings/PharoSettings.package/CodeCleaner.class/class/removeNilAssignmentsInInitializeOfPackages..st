simplification
removeNilAssignmentsInInitializeOfPackages: aCollectionOfPackages
	| methods |
	methods := (aCollectionOfPackages flatCollect: #methods) select: [ :method | method selector = #initialize and: [ method isFromTrait not ] ].
	methods
		do: [ :method | 
			| ast |
			ast := method ast.
			(ast assignmentNodes select: [ :assignment | assignment value value isNil ])
				ifNotEmpty: [ :nilAssignmentNode | 
					nilAssignmentNode do: #removeFromTree.
					method methodClass compile: ast formattedCode ] ]