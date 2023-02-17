initialization
registerIfPresentProjectAt: location subdirectory: subdirectory
	location exists ifFalse: [ ^ self ].

	[ (IceRepositoryCreator new
		location: location;
		subdirectory: subdirectory;
		createRepository) register ]
		on: IceDuplicatedRepository
		do: [ "nothing" ]