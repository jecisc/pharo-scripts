initialization
darkThemeClass
	^ SystemVersion current major >= 7
		ifTrue: [ DarkBlueTheme ]
		ifFalse: [ Pharo3DarkTheme ]