private
lineLimitsOf: aBlockNode
	| text limits |
	limits := OrderedCollection new.
	[text := textModel text copyFrom: aBlockNode left to: aBlockNode right] on: Error do: [ text := ''].
	text string lineIndicesDo: [ :start :endWithout :endWith | limits add: start -> endWith ].
	^ limits