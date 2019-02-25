initialization
installNativeBrowser
	<script>
	| sourcesDir |
	SystemVersion current major > 7 ifTrue: [ "Is already in the system." ^ self ].
	sourcesDir := self sharedRepositoryFolder / 'jecisc' / 'Native-Browser' / 'src'.

	sourcesDir exists
		ifTrue: [ Metacello new
				repository: 'tonel://' , sourcesDir fullName;
				baseline: 'NativeBrowser';
				load ]
		ifFalse: [ (UIManager default questionWithoutCancel: 'Clone Native-Browser?')
				ifTrue: [ Metacello new
						githubUser: 'jecisc'
							project: 'Native-Browser'
							commitish: 'master'
							path: 'src';
						baseline: 'NativeBrowser';
						load ] ]