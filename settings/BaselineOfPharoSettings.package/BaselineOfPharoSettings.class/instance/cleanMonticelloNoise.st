baselines
cleanMonticelloNoise
	SystemVersion current major < 7
		ifTrue: [ | packages |
			packages := #('FreeType' 'Kernel' 'Komitter' 'NECompletion' 'Nautilus' 'Traits' '_UnpackagedPackage').
			MCWorkingCopy allInstances select: [ :p | packages includes: p package name ] thenDo: [ :p | p modified: false ] ]