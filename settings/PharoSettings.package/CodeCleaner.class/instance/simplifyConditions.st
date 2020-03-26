simplification
simplifyConditions
	| r |
	r := RBParseTreeRewriter new
		replace: '`@receiver isNil ifTrue: `@arg' with: '`@receiver ifNil: `@arg';
		replace: '`@receiver isNil ifFalse: `@arg' with: '`@receiver ifNotNil: `@arg';
		replace: '`@receiver isNotNil ifTrue: `@arg' with: '`@receiver ifNotNil: `@arg';
		replace: '`@receiver isNotNil ifFalse: `@arg' with: '`@receiver ifNil: `@arg';
		replace: '`@receiver isNil ifTrue: `@arg ifFalse: `@arg2' with: '`@receiver ifNil: `@arg ifNotNil: `@arg2';
		replace: '`@receiver isNil ifFalse: `@arg ifTrue: `@arg2' with: '`@receiver ifNil: `@arg2 ifNotNil: `@arg';
		replace: '`@receiver isNotNil ifTrue: `@arg ifFalse: `@arg2' with: '`@receiver ifNil: `@arg2 ifNotNil: `@arg';
		replace: '`@receiver isNotNil ifFalse: `@arg ifTrue: `@arg2' with: '`@receiver ifNil: `@arg ifNotNil: `@arg2';
		yourself.

	self rewriteMethodsOf: self definedClasses with: r