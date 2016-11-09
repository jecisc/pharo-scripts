initialization
setMonticelloInfos
	<script>
	| creds file |
	file := self resourcesFolder / 'Creds'.
	file exists
		ifFalse: [ | cred |
			cred := Dictionary new.
			cred at: #username put: (UIManager default textEntry: 'Username').
			cred
				at: #password
				put: (UIManager default requestPassword: 'Password').
			file
				writeStreamDo: [ :s | s nextPutAll: (STON toStringPretty: cred) ] ].
	creds := STON fromString: file contents.
	MCRepositoryGroup default repositories
		do: [ :rep | 
			[ rep user: (creds at: #username).
			rep password: (creds at: #password) ]
				on: Error
				do: [  ] ]