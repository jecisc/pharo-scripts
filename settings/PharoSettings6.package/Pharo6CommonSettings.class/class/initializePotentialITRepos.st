initialization
initializePotentialITRepos
	<script>
	| file itProjects |
	file := PharoCommonSettings resourcesFolder / 'loc'.
	file exists
		ifFalse: [ | cred |
			cred := Dictionary new.
			cred at: #it put: (UIManager default textEntry: 'Path to IT folder').
			file writeStreamDo: [ :s | s nextPutAll: (STON toStringPretty: cred) ] ].
	itProjects := ((STON fromString: file contents) at: #it) asFileReference directories.
	IceRepository registry do: [ :repo | itProjects detect: [ :e | e basename = repo name ] ifFound: [ :dir | repo location: dir ] ]