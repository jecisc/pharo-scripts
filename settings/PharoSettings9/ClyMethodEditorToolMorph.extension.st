Extension { #name : #ClyMethodEditorToolMorph }

{ #category : #'*PharoSettings9' }
ClyMethodEditorToolMorph >> myTextChanged: args [
	super textChanged: args anyOne.
	ast := self currentEditedAST.
	textMorph segments copy do: #delete.
	IconStyler new
	   stylerClasses: {ErrorNodeStyler . SemanticMessageIconStyler . SemanticVariableIconStyler . BlockStyler };
		styleText: textModel withAst: ast.
	^ ast
]
