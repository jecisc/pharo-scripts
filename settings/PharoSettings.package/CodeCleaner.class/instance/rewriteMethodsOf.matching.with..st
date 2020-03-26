execution
rewriteMethodsOf: classes matching: aBlock with: rewriter
	classes
		do: [ :class | 
			class localMethods
				select: aBlock
				thenDo: [ :m | 
					| n |
					n := m parseTree.
					(rewriter executeTree: n) ifTrue: [ class compile: n formattedCode ] ] ]
		displayingProgress: [ :c | c printString ]