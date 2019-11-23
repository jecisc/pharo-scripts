codax
flushAll
	<name: #'Flush all'>
	(self class environment at: #MooseEntity) allSubInstances
		do: [ :entity | entity privateState flush ]
		displayingProgress: [ :entity | 'Cleaning cache of ' , entity mooseName ]