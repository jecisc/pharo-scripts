class names
ensureTestCasesEndsWithTestInsteadOfTestsForPackages: aCollectionOfPackage
	| testClasses |
	testClasses := (aCollectionOfPackage flatCollect: #definedClasses) select: #isTestCase.
	testClasses
		do: [ :class | (class name endsWith: 'Tests') ifTrue: [ (RBRenameClassRefactoring rename: class to: (class name withoutSuffix: 'Tests') , 'Test') execute ] ]