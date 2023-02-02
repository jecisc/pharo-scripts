as yet unclassified
findDependenciesToAPackage

	<script>
	self open: '| report |
	report := DADependencyChecker new computeImageDependencies.
	(report knownDependantsOf: ''Garage'') inspect'