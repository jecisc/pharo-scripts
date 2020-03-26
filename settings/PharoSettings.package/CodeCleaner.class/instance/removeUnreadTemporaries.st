simplification
removeUnreadTemporaries
	self localMethods
		do: [ :method | 
			| ast |
			ast := method ast.
			(ast allSequenceNodes flatCollect: [ :sequence | sequence temporaries select: #isReadAtLeastOnce ])
				ifNotEmpty: [ :temporariesToRemove | 
					temporariesToRemove
						do: [ :temp | 
							temp declaringScope
								nodesDo: [ :node | (node isTemp and: [ node name = temp name ]) ifTrue: [ node parent replaceWith: node parent value ] ];
								removeTemporaryNamed: temp name ].
					method methodClass compile: ast formattedCode ] ]