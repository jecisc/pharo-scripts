as yet unclassified
buildSelectBackgroundOn: aBuilder
	self backgroundFolder allFiles
		do: [ :background | 
			(aBuilder item: background basename asSymbol)
				action: [ PolymorphSystemSettings desktopImageFileName: background fullName ];
				iconName: #smallDoIt ]