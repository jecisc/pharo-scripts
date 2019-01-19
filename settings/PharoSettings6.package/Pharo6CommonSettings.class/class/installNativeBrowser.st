initialization
installNativeBrowser
	<script>
	| sourcesDir |
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