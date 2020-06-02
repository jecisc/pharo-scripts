testing
shouldBeActivatedInContext: aBrowserContext
	^ "(super shouldBeActivatedInContext: aBrowserContext) and: [ aBrowserContext selectedClasses anySatisfy: #hasTraitComposition ]" false "Too buggy for now"