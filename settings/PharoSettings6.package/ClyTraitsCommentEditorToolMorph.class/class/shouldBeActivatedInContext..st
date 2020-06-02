testing
shouldBeActivatedInContext: aBrowserContext
	^ (super shouldBeActivatedInContext: aBrowserContext) and: [ aBrowserContext selectedClasses anySatisfy: #hasTraitComposition ]