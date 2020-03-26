simplification
removeNilAssignmentsInInitialize
	(self localMethods select: [ :method | method selector = #initialize ])
		do: [ :method | 
			| ast |
			ast := method ast.
			(ast assignmentNodes select: [ :assignment | assignment value value isNil ])
				ifNotEmpty: [ :nilAssignmentNode | 
					nilAssignmentNode do: #removeFromTree.
					method methodClass compile: ast formattedCode ] ]