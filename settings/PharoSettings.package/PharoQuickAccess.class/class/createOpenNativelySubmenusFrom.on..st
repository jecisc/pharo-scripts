world menu
createOpenNativelySubmenusFrom: aFolder on: aBuilder
	self recursivelyCreateCommandForRepositoriesFrom: aFolder action: [ :dir | dir openInOSFileBrowser ] prefix: '  ' on: aBuilder