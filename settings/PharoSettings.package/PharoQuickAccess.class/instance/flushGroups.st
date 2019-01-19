synectique
flushGroups
	<name: #'Flush groups'>
	(self class environment at: #MooseEntity) allSubInstances
		do: [ :entity | entity privateState flushGroups ]
		displayingProgress: [ :entity | 'Cleaning cache of ' , entity mooseName ]