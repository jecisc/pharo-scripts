cleaning
cleanPackages: aCollectionOfPackages
	^ self new
		packages: aCollectionOfPackages;
		clean