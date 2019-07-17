conveniance
templateDependencies
	<name: #'Template find dependencies'>
	GTPlayground
		openContents:
			'report := DADependencyChecker new computeImageDependencies.
report knownDependantsOf: ''Glamour-Examples'''