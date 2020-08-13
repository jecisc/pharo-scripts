world menu
createOpenNativelySubmenusFrom: aFolder on: aBuilder
	self recursivelyCreateCommandForRepositoriesFrom: aFolder directories action: [ :dir | dir openInNativeBrowser ] prefix: '  ' on: aBuilder