world menu
createOpenNativelySubmenusFrom: aFolder on: aBuilder
	self recursivelyCreateCommandForRepositoriesFrom: aFolder action: [ :dir | dir openInNativeBrowser ] prefix: ' ' on: aBuilder