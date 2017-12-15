initialization
launchThemeProcess
	<script>
	| installThemeBlock currentTheme |
	installThemeBlock := [ | theme |
	theme := (Time now between: '7:00am' asTime and: '9:00pm' asTime)
		ifTrue: [ SystemVersion current major >= 7
				ifTrue: [ PharoDarkTheme ]
				ifFalse: [ Pharo3DarkTheme ] ]
		ifFalse: [ SystemVersion current major >= 7
				ifTrue: [ PharoLightTheme ]
				ifFalse: [ Pharo3Theme ] ].
	theme = currentTheme
		ifFalse: [ currentTheme := theme.
			PolymorphSystemSettings uiThemeClass: currentTheme.
			self setThemeSetting ] ].
	[ [ installThemeBlock value.
	5 minutes asDelay wait ] repeat ] newProcess
		priority: Processor systemBackgroundPriority;
		name: 'changeTheme';
		resume