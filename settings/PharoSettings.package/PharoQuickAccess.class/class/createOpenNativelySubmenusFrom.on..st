world menu
createOpenNativelySubmenusFrom: aFolder on: aBuilder
	self recursivelyCreateCommandForRepositoriesFrom: aFolder action: [ :dir | dir openInNativeBrowser ] on: aBuilder