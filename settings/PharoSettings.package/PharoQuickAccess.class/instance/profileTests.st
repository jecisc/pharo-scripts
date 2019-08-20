templates
profileTests
	<name: #'Variable usage'>
	GTPlayground
		openContents:
			'packageSelectionBlock := [ :e | e name beginsWith: ''Traits'' ].
testSuite := TestSuite new.
	
((RPackageOrganizer default packages select: packageSelectionBlock) flatCollect: #classes) select: [ :e | e inheritsFrom: TestCase ] thenDo: [ :e | e addToSuiteFromSelectors: testSuite ].

[ testSuite run ] spy'