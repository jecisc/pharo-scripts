class refactoring
rewritePatterns

	<script>
	self open: 'r := RBParseTreeRewriter new.
r replace: ''`@receiver assert: `@arg = `@arg2'' with: ''`@receiver assert: `@arg equals: `@arg2''.
r replace: ''`@receiver deny: `@arg = `@arg2'' with: ''`@receiver deny: `@arg equals: `@arg2''.


classes := TestCase allSubclasses select: [ :e | e package name first = $c ].

classes do: [ :class |

	class localMethods select: [ :m | m selector beginsWith: ''test'' ] thenDo: [ :m |
		n := m parseTree.
		(r executeTree: n) ifTrue: [ class compile: n formattedCode].
		 ]
	 ]
	displayingProgress: [ :c | c printString ]'