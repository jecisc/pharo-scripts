as yet unclassified
findDependenciesToAPackage
	<script>
	| report |
	report := DADependencyChecker new computeImageDependencies.
	(report knownDependantsOf: 'Garage') inspect