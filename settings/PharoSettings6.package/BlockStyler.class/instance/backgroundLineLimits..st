private
backgroundLineLimits: aCollection
	| backgroundLineLimits |
	backgroundLineLimits := aCollection withIndexCollect: [ :line :index | index = 1 ifTrue: [ line ] ifFalse: [ line key + nesting -> line value ] ].
	^ backgroundLineLimits select: [ :line | line value > line key ]