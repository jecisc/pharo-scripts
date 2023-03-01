defaults
defaultThemes
	DefaultThemes
		ifNil: [ DefaultThemes := {((SystemVersion current major >= 7 ifTrue: [ DarkBlueTheme ] ifFalse: [ Pharo3DarkTheme ]) -> (Color white alpha: 0.15)).
			((SystemVersion current major >= 7 ifTrue: [ PharoLightTheme ] ifFalse: [ Pharo3Theme ]) -> (Color black alpha: 0.1))} asDictionary ].
	^ DefaultThemes