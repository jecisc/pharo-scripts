initialization
darkThemeClass
	^ SystemVersion current major >= 7
		ifTrue: [ PharoDarkTheme ]
		ifFalse: [ Pharo3DarkTheme ]