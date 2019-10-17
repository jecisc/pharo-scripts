templates
renameMethodsWithDeprecation
	<name: #'Batch method rename with deprecations'>
	GTPlayground
		openContents:
			'class := FM3Class.
from := ''Attributes''.
to := ''Properties''.
deprecatedProtocol := ''*Famix-Deprecated''.

signatureBuilder := [ :selector |
	selector isUnary ifTrue: [ selector ] ifFalse: [
	| count |
	count := 1. 
	String streamContents: [ :s | selector keywords do: [ :key | s nextPutAll: key; space; nextPutAll: ''arg''; print: count; space. count := count + 1 ] ] ] ].

class methods
	select: [ :method | method selector includesSubstring: from ]
	thenDo: [ :method | 
		| oldSelector newSelector |
		oldSelector := method selector.
		newSelector := (method selector copyReplaceAll: from with: to).

		(RBRenameMethodRefactoring
			renameMethod: oldSelector
			in: class
			to: newSelector
			permutation: (1 to: method numArgs) asArray) execute.
			
		class compile: (''{1}
	{2}
	^ self {3}'' format: {signatureBuilder value: oldSelector . ''self deprecated: ''''Use #'', newSelector , '' instead.'''' transformWith: ''''``@object '' , (RBParseTreeSearcher buildSelectorString: oldSelector),'''''' -> ''''``@object '' , (RBParseTreeSearcher buildSelectorString: newSelector) ,''''''.''. signatureBuilder value: newSelector }).
	
		deprecatedProtocol ifNotNil: [ :p | (class>>oldSelector) protocol: p ].
		
		
			 ].'