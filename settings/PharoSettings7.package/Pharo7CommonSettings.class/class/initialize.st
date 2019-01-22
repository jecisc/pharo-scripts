initialization
initialize
	self
		installSpecRepository;
		addMooseRepositories;
		resetMenuBar;
		addIcebergHack;
		prepareForPharoContribution.
		
	MenubarMorph reset