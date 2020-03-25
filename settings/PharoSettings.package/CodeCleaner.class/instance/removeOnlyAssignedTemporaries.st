simplification
removeOnlyAssignedTemporaries
	self localMethods
		do: [ :method | 
			| ast |
			ast := method ast.
			(ast temporaries
				select: [ :temp | 
					| isRead |
					isRead := false.
					ast statements
						do:
							[ :statement | statement nodesDo: [ :node | (node isVariable and: [ node name = temp name ]) ifTrue: [ node isRead ifTrue: [ isRead := true ] ] ] ].
					isRead not ])
				ifNotEmpty: [ :temporariesToRemove | 
					temporariesToRemove
						do: [ :temp | 
							ast statements
								do: [ :statement | 
									statement nodesDo: [ :node | (node isVariable and: [ node name = temp name ]) ifTrue: [ node parent replaceWith: node parent value ] ].
									(ast allChildren select: [ :each | each isSequence ])
										detect: [ :sequence | sequence defines: temp name ]
										ifFound: [ :s | s removeTemporaryNamed: temp name ] ] ].
					method methodClass compile: ast formattedCode ] ]