class names
ensureTestCasesEndsWithTestInsteadOfTests
	self definedTestCases
		do: [ :class | (class name endsWith: 'Tests') ifTrue: [ (RBRenameClassRefactoring rename: class to: (class name withoutSuffix: 'Tests') , 'Test') execute ] ]