templates
dependencies
	<name: #'Find dependencies'>
	GTPlayground
		openContents:
			'report := DADependencyChecker new computeImageDependencies.
report knownDependantsOf: ''Glamour-Examples'''