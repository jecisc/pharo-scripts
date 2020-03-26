rightSuper
ensureSuperTearDownForMethods: methods
	methods
		select: [ :method | 
			method methodClass isTestCase
				and: [ method selector = #tearDown
						and: [ (method ast sendNodes ifNotEmpty: [ :nodes | nodes last isSuperSend and: [ nodes last selector = #tearDown ] ] ifEmpty: [ true ]) not ] ] ]
		thenDo: [ :method | 
			| ast |
			ast := method ast.
			ast sendNodes select: [ :each | each isSuperSend and: [ each selector = #tearDown ] ] thenDo: #removeFromTree.
			ast body addNodeLast: (RBMessageNode receiver: (RBVariableNode named: #super) selector: #tearDown).
			method methodClass compile: ast formattedCode ]