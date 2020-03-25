simplification
removeMethodsOnlyCallingSuper
	| matcher |
	matcher := RBParseTreeSearcher justSendsSuper.
	self localMethods
		do: [ :method | (method pragmas isEmpty and: [ matcher executeMethod: method ast initialAnswer: false ]) ifTrue: [ method removeFromSystem ] ]