testing
canBeExecutedInContext: aToolContext
	| location | 
	location := aToolContext item location.
	^ location isNotNil and: [ location exists ]