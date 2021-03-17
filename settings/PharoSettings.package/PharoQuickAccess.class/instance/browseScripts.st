browse-settings
browseScripts
	<name: #'Browse scripts'>
	self class environment at: #Scripts ifPresent: [ :class | class class browse ]