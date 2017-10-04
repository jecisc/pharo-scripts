defaults
defaultThemes
	DefaultThemes
		ifNil: [ DefaultThemes := {(UIThemeWatery -> (Color black alpha: 0.1)).
			(GLMWhitespaceTheme -> (Color black alpha: 0.1)).
			(Pharo3DarkTheme -> (Color white alpha: 0.15)).
			(Pharo3Theme -> (Color black alpha: 0.1))} asDictionary ].
	^ DefaultThemes