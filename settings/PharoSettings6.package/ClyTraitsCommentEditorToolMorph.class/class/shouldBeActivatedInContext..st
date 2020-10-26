testing
shouldBeActivatedInContext: aToolContext
	(super shouldBeActivatedInContext: aToolContext) ifFalse: [ ^ false ].

	^ aToolContext isSelectedClassUsesTraits