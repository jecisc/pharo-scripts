world menu
buildOpenNativelyOn: aBuilder
	(aBuilder item: #'Pharo scripts root')
		action: [ self rootFolder openInOSFileBrowser ];
		order: 1;
		iconName: #smallDoIt.
	self createOpenNativelySubmenusFrom: self sharedRepositoryFolder on: aBuilder