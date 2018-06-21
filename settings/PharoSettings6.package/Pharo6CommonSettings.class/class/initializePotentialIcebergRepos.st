initialization
initializePotentialIcebergRepos
	<script>
	| file projects |
	file := PharoCommonSettings resourcesFolder / 'localisation'.
	file exists
		ifFalse: [ | cred |
			cred := Dictionary new.
			cred at: #dir put: (UIManager default textEntry: 'Path to Iceberg default folder').
			file writeStreamDo: [ :s | s nextPutAll: (STON toStringPretty: cred) ] ].
	projects := OrderedCollection new.
	self collectAllSubprojectsFrom:  ((STON fromString: file contents) at: #dir) asFileReference into: projects.
	IceRepository registry do: [ :repo | projects detect: [ :e | e basename = repo name and: [ (repo location isNil or: [ repo location exists not ]) ] ] ifFound: [ :dir | repo location: dir ] ]