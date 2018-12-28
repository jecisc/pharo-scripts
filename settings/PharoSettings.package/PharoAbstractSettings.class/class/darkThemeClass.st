initialization
darkThemeClass
	^ SystemVersion current major >= 7
		ifTrue: [ MyDarkTheme ]
		ifFalse: [ Pharo3DarkTheme ]