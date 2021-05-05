class initialization
installFlagBrowser
	<script>
	| sourcesDir |
	sourcesDir := self sharedRepositoryFolder / 'jecisc' / 'FlagBrowser' / 'src'.

	sourcesDir exists
		ifTrue: [ Metacello new
				repository: 'tonel://' , sourcesDir fullName;
				baseline: 'FlagBrowser';
				load ]
		ifFalse: [ (UIManager default questionWithoutCancel: 'Clone FlagBrowser?')
				ifTrue: [ Metacello new
						githubUser: 'jecisc'
							project: 'FlagBrowser'
							commitish: 'master'
							path: 'src';
						baseline: 'FlagBrowser';
						load ] ]