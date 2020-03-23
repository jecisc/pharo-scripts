execution
executeOnAll: classes
	classes
		do: [ :class | 
			class localMethods
				select: methodMatchBlock
				thenDo: [ :m | 
					| n |
					n := m parseTree.
					(rewriter executeTree: n) ifTrue: [ class compile: n formattedCode ] ] ]
		displayingProgress: [ :c | c printString ]