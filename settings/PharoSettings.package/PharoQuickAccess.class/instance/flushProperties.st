synectique
flushProperties
	<name: #'Flush properties'>
	(self class environment at: #MooseEntity) allSubInstances
		do: [ :entity | entity privateState flushProperties ]
		displayingProgress: [ :entity | 'Cleaning cache of ' , entity mooseName ]