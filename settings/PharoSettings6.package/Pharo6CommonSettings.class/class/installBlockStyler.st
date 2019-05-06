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
		at: self darkThemeClass
		put: (Color lightBlue alpha: 0.05).
	(self class environment at: #BlockStyler) defaultThemes
		at: self lightThemeClass
		put: (Color blue alpha: 0.05)