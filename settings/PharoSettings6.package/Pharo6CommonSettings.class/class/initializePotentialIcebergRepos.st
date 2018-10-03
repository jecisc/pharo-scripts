initialization
initializePotentialIcebergRepos
	<script>
	| projects |
	projects := OrderedCollection new.
	self collectAllSubprojectsFrom: self sharedRepositoryFolder into: projects.
	IceRepository registry do: [ :repo | projects detect: [ :e | e basename = repo name and: [ repo location isNil or: [ repo location exists not ] ] ] ifFound: [ :dir | repo location: dir ] ]