initialization
installNativeBrowser
	<script>
	| sourcesDir |
	sourcesDir := self sharedRepositoryFolder / 'jecisc' / 'Native-Browser' / 'src'.

	sourcesDir exists ifFalse: [ UIManager default alert: 'Clone Native-Browser to ' , sourcesDir parent parent fullName ].

	Metacello new
		baseline: 'NativeBrowser';
		repository: 'tonel://' , sourcesDir fullName;
		load