initialization
installBlockStyler
	<script>
	Metacello new
		filetreeDirectory: (PharoCommonSettings resourcesFolder / 'ProjectCache' / 'BlockStyler') fullName , '/repository';
		baseline: 'BlockStyler';
		load.
	(self class environment at: #BlockStyler) defaultThemes
		at:
			(SystemVersion current major >= 7
				ifTrue: [ PharoDarkTheme ]
				ifFalse: [ Pharo3DarkTheme ])
		put: (Color green alpha: 0.07).
	(self class environment at: #BlockStyler) defaultThemes
		at:
			(SystemVersion current major >= 7
				ifTrue: [ PharoLightTheme ]
				ifFalse: [ Pharo3Theme ])
		put: (Color blue alpha: 0.07).
	(self class environment at: #BlockStyler)
		compile:
			'lineLimitsOf: aBlockNode
	| text limits |
	limits := OrderedCollection new.
	[text := textModel text copyFrom: aBlockNode left to: aBlockNode right] on: Error do: [ text := ''''].
	text string lineIndicesDo: [ :start :endWithout :endWith | limits add: start -> endWith ].
	^ limits'