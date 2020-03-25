rightSuper
ensureSuperInitializeForMethods: methods
	methods
		select: [ :method | 
			method methodClass isInstanceSide
				and: [ method selector = #initialize
						and: [ (method ast sendNodes ifNotEmpty: [ :nodes | nodes anySatisfy: [ :node | node isSuperSend and: [ node selector = #initialize ] ] ]) not ] ] ]
		thenDo: [ :method | 
			| ast |
			ast := method ast.
			ast body addNodeFirst: (RBMessageNode receiver: (RBVariableNode named: #super) selector: #initialize).
			method methodClass compile: ast formattedCode ]