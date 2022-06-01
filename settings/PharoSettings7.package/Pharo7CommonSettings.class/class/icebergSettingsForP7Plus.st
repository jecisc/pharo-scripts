initialization
icebergSettingsForP7Plus

	<script>
	| creds file |
	file := self resourcesFolder / 'CredsIceberg'.
	file exists ifFalse: [ 
		file writeStreamDo: [ :s | 
			s nextPutAll: (STON toStringPretty:
					 (Dictionary with: #username -> (UIManager default textEntry: 'Username') with: #password -> (UIManager default requestPassword: 'Password'))) ] ].
	creds := STON fromString: file contents.

	IceCredentialStore current
		storeCredential: (IcePlaintextCredentials new
				 username: (creds at: #username);
				 password: (creds at: #password);
				 yourself)
		forHostname: 'github.com'.

	"Open Iceberg. I often need it."
	SystemVersion current major < 10
		ifTrue: [ IceTipRepositoriesBrowser new openWithSpec ]
		ifFalse: [ IceTipRepositoriesBrowser new open ]