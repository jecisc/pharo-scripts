*PharoSettings7
projectAlt
	^ [ IceProjectReader readProjectFrom: self ]
		on: NotFound
		do: [ self repository fetch.
			IceProjectReader readProjectFrom: self ]