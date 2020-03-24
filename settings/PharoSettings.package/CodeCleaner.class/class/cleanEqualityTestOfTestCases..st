equality
cleanEqualityTestOfTestCases: aCollection
	self new
		replace: '`@receiver assert: `@arg = `@arg2' with: '`@receiver assert: `@arg equals: `@arg2';
		replace: '`@receiver deny: `@arg = `@arg2' with: '`@receiver deny: `@arg equals: `@arg2';
		replace: '`@receiver assert: `@arg == `@arg2' with: '`@receiver assert: `@arg identicalTo: `@arg2';
		replace: '`@receiver deny: `@arg == `@arg2' with: '`@receiver deny: `@arg identicalTo: `@arg2';
		replace: '`@receiver assert: `@arg = true' with: '`@receiver assert: `@arg';
		replace: '`@receiver deny: `@arg = true' with: '`@receiver deny: `@arg';
		replace: '`@receiver assert: `@arg = false' with: '`@receiver deny: `@arg';
		replace: '`@receiver deny: `@arg = false' with: '`@receiver assert: `@arg';
		replace: '`@receiver assert: `@arg equals: true' with: '`@receiver assert: `@arg';
		replace: '`@receiver deny: `@arg equals: true' with: '`@receiver deny: `@arg';
		replace: '`@receiver assert: `@arg equals: false' with: '`@receiver deny: `@arg';
		replace: '`@receiver deny: `@arg equals: false' with: '`@receiver assert: `@arg';
		methodMatchBlock: [ :m | m selector beginsWith: 'test' ];
		executeOnAll: aCollection