world menu
buildSelectBackgroundOn: aBuilder
	((self backgroundFolder allFiles reject: [ :f | f basename beginsWith: '.' ]) sorted: #basename ascending)
		do: [ :background | 
			(aBuilder item: background basename asSymbol)
				action: [ PolymorphSystemSettings desktopImageFileName: background fullName ];
				iconName: #smallDoIt ]