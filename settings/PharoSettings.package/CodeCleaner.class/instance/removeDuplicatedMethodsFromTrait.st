simplification
removeDuplicatedMethodsFromTrait
	self definedClasses
		select: [ :class | class isTrait not and: [ class hasTraitComposition ] ]
		thenDo: [ :class | 
			class localMethods
				do:
					[ :method | (class traitComposition compiledMethodAt: method selector ifAbsent: [ nil ])
										ifNotNil: [ :m | m ast = method ast ifTrue: [ method removeFromSystem ] ] ] ]