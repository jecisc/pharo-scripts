world menu
createAddToIcebergSubmenusFrom: aFolder on: aBuilder
	self
		recursivelyCreateCommandForRepositoriesFrom: aFolder directories
		action: [ :dir | 
			(IceRepositoryCreator new
				location: dir;
				createRepository) register.
				self focusIceberg ]
		prefix: ' '
		on: aBuilder