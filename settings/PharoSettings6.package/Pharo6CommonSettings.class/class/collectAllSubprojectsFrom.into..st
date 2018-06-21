initialization
collectAllSubprojectsFrom: aDirectory into: aCollection
	(aDirectory directories anySatisfy: [ :e | e basename = '.git' ]) ifTrue: [ aCollection add: aDirectory ] ifFalse: [ aDirectory directories do: [ :dir | self collectAllSubprojectsFrom: dir into: aCollection ] ]