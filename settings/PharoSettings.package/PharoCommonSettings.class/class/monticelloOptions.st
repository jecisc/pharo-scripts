initialization
monticelloOptions

	<script>
	| creds file |
	file := self resourcesFolder / 'Creds'.
	file exists ifFalse: [
		| cred |
		cred := Dictionary new.
		cred at: #username put: (UIManager default textEntry: 'Username').
		cred at: #password put: (UIManager default requestPassword: 'Password').
		file writeStreamDo: [ :s | s nextPutAll: (STON toStringPretty: cred) ] ].
	creds := STON fromString: file contents.
	MCRepositoryGroup default repositories do: [ :rep |
		[
		rep user: (creds at: #username).
		rep password: (creds at: #password) ]
			on: Error
			do: [  ] ].
	MCCacheRepository cacheDirectory: ((self rootFolder / 'package-cache')
			 ensureCreateDirectory;
			 yourself).
	MCGitHubRepository cacheDirectory: (((OSPlatform current isWindows
			   ifTrue: [ FileLocator C "This is a hack to shorten windows's paths because windows have a max path of 255 characters :(" ]
			   ifFalse: [ self rootFolder ]) / 'github-cache')
			 ensureCreateDirectory;
			 yourself).
	MCWorkingCopyBrowser order: 4.
	MCRepositoryGroup default repositories
		select: [ :r | (r isKindOf: MCSmalltalkhubRepository) and: [ r location includesSubstring: 'Pharo/Pharo' ] ]
		thenDo: [ :r | MCRepositoryGroup default removeRepository: r ]