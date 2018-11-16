initialization
registerIfPresentProjectOf: owner named: project
	self registerIfPresentProjectOf: owner named: project subdirectory: 'src'