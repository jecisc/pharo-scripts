initialization
installBlockStyler
	<script>
	| sourcesDir |
	sourcesDir := self sharedRepositoryFolder / 'jecisc' / 'BlockStyler' / 'repository'.

	sourcesDir exists
		ifTrue: [ Metacello new
				filetreeDirectory: sourcesDir fullName;
				baseline: 'BlockStyler';
				load ]
		ifFalse: [ (UIManager default questionWithoutCancel: 'Clone BlockStyler?')
				ifTrue: [ Metacello new
						githubUser: 'jecisc'
							project: 'BlockStyler'
							commitish: 'master'
							path: 'repository';
						baseline: 'BlockStyler';
						load ]
				ifFalse: [ ^ self ] ].

	(self class environment at: #BlockStyler) defaultThemes
		at: (SystemVersion current major >= 7 ifTrue: [ PharoDarkTheme ] ifFalse: [ Pharo3DarkTheme ])
		put: (Color green alpha: 0.07).
	(self class environment at: #BlockStyler) defaultThemes
		at: (SystemVersion current major >= 7 ifTrue: [ PharoLightTheme ] ifFalse: [ Pharo3Theme ])
		put: (Color blue alpha: 0.07)