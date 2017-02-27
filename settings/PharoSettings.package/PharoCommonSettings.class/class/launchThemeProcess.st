initialization
launchThemeProcess
	<script>
	| installThemeBlock currentTheme |
	installThemeBlock := [ | theme |
	theme := (Time now between: '7:00am' asTime and: '9:00pm' asTime)
		ifTrue: [ Pharo3DarkTheme ]
		ifFalse: [ Pharo3Theme ].
	theme = currentTheme
		ifFalse: [ currentTheme := theme.
			PolymorphSystemSettings uiThemeClass: currentTheme ] ].
	[ [ installThemeBlock value.
	5 minutes asDelay wait ] repeat ] newProcess
		priority: Processor systemBackgroundPriority;
		name: 'changeTheme';
		resume