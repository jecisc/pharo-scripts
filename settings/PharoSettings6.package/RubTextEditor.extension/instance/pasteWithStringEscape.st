*PharoSettings6
pasteWithStringEscape
	self replace: self selectionInterval with: (self clipboardText copyReplaceAll: '''' with: '''''') and: [ self selectAt: self pointIndex ]