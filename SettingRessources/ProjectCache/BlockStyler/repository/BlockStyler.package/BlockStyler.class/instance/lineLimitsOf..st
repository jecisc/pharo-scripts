private
lineLimitsOf: aBlockNode
	| text limits |
	limits := OrderedCollection new.
	text := textModel text copyFrom: aBlockNode left to: aBlockNode right.
	text string lineIndicesDo: [ :start :endWithout :endWith | limits add: start -> endWith ].
	^ limits