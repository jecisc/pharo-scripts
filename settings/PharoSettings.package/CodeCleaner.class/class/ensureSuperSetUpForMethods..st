rightSuper
ensureSuperSetUpForMethods: methods
	methods
		select: [ :method | 
			method methodClass isTestCase
				and: [ method selector = #setUp and: [ (method ast sendNodes ifNotEmpty: [ :nodes | nodes first isSuperSend and: [ nodes first selector = #setUp ] ]) not ] ] ]
		thenDo: [ :method | 
			| ast |
			ast := method ast.
			ast sendNodes select: [ :each | each isSuperSend and: [ each selector = #setUp ] ] thenDo: #removeFromTree.
			ast body addNodeFirst: (RBMessageNode receiver: (RBVariableNode named: #super) selector: #setUp).
			method methodClass compile: ast formattedCode ]