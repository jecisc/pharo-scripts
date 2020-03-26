simplification
removeUnreadTemporaries
	self localMethods
		do: [ :method | 
			| ast updated |
			ast := method ast.
			updated := false.
			ast allSequenceNodes
				do: [ :sequence | 
					(sequence temporaries select: [ :temp | sequence allChildren noneSatisfy: [ :node | node isVariable and: [ node name = temp name and: [ node isRead ] ] ] ])
						ifNotEmpty: [ :temporariesToRemove | 
							temporariesToRemove
								do: [ :temp | 
									sequence nodesDo: [ :node | (node isVariable and: [ node name = temp name ]) ifTrue: [ node parent replaceWith: node parent value ] ].
									sequence removeTemporaryNamed: temp name ].
							updated := true ] ].
			updated ifTrue: [ method methodClass compile: ast formattedCode ] ]