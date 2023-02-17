class refactoring
condenseCode

	<script>
	self open: 'cms := CompiledMethod allInstances select: [:each |
each package ifNil: [ false ] ifNotNil: [:p |
	p name beginsWith: ''Zinc'' ] ].


cms do: [:cm |
    ((RBRefactoryChangeFactory instance)
         addMethodSource: (ReMethodSourceCleaner clean: cm sourceCode) in: cm origin) execute ]'