Extension { #name : 'ClyMethodEditorToolMorph' }

{ #category : '*PharoSettings' }
ClyMethodEditorToolMorph >> myTextChanged: args [

	super textChanged: args anyOne.
	ast := self currentEditedAST.
	textMorph segments copy do: #delete.
	self flag: #pharo10.
	IconStyler new
		stylerClasses: {
				ErrorNodeStyler.
				SemanticMessageIconStyler.
				(self class environment at: ((self class environment hasBindingThatBeginsWith: #SemanticVariableIconStyler)
							  ifTrue: [ #SemanticVariableIconStyler ]
							  ifFalse: [ #SemanticWarningIconStyler ])).
				BlockStyler };
		styleText: textModel withAst: ast.
	^ ast
]
