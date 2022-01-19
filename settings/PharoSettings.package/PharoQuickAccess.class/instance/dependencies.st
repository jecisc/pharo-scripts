templates
dependencies
	<name: #'Find dependencies'>
	self openOn:
			'report := DADependencyChecker new computeImageDependencies.
report knownDependantsOf: ''Glamour-Examples'''