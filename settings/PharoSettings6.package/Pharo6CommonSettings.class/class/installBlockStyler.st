initialization
installBlockStyler
	<script>
	| sourcesDir |
	sourcesDir := self sharedRepositoryFolder / 'jecisc' / 'BlockStyler' / 'repository'.

	sourcesDir exists ifFalse: [ UIManager default alert: 'Clone BlockStyler to ' , sourcesDir parent parent fullName ].

	Metacello new
		filetreeDirectory: sourcesDir fullName;
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
		put: (Color blue alpha: 0.07)