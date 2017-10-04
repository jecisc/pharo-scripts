initialization
installBlockStyler
	Metacello new
		filetreeDirectory: (PharoCommonSettings resourcesFolder / 'ProjectCache' / 'BlockStyler') fullName , '/repository';
		baseline: 'BlockStyler';
		load.
	(self class environment at: #BlockStyler) defaultThemes at: Pharo3DarkTheme put: (Color green alpha: 0.07).
	(self class environment at: #BlockStyler) defaultThemes at: Pharo3Theme put: (Color blue alpha: 0.07)