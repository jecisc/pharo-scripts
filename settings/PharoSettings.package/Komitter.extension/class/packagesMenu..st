*PharoSettings
packagesMenu: aBuilder
	<nautilusGlobalPackageMenu>
	| packageNames target |
	target := aBuilder model.
	(packageNames := target selectedPackages collect: #name) ifEmpty: [ ^ target ].
	(aBuilder item: #'Commit with Komitter...')
		action:
				[ self class openAndCommitToMonticelloWorkingCopiesFilteredBy: [ :workingCopy | packageNames includes: workingCopy package name ] ];
		order: 1295;
		help: 'Open a Komitter on the selected package(s)';
		icon: self class taskbarIcon