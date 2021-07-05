benchmarking
benchTestSuite
	<script>
	self open: '| packageSelectionBlock testSuite |
	packageSelectionBlock := [ :e | e name beginsWith: ''IngeProj'' ].
	testSuite := TestSuite new.

	((RPackageOrganizer default packages select: packageSelectionBlock) flatCollect: #classes)
		select: [ :e | e inheritsFrom: TestCase ]
		thenDo: [ :e | e addToSuiteFromSelectors: testSuite ].

	[ testSuite run ] spy'