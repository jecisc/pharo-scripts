Extension { #name : #RubTextEditor }

{ #category : #'*PharoSettingsUpTo8' }
RubTextEditor >> pasteWithStringEscape [
	self replace: self selectionInterval with: (self clipboardText copyReplaceAll: '''' with: '''''') and: [ self selectAt: self pointIndex ]
]
