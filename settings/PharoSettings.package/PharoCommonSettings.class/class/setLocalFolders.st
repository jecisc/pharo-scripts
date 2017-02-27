initialization
setLocalFolders
	<script>
	GTPlayBook cacheDirectory: StartupPreferencesLoader preferencesGeneralFolder / 'play-cache'.
	GTPlayBook stashDirectory: StartupPreferencesLoader preferencesGeneralFolder / 'play-stash'.
	MCCacheRepository cacheDirectory: StartupPreferencesLoader preferencesGeneralFolder / 'package-cache'.
	MCGitHubRepository
		cacheDirectory:
			(((OSPlatform current isWindows
				ifTrue: [ FileLocator C	"This is a hack to shorten windows's paths because windows have a max path of 255 characters :(" ]
				ifFalse: [ StartupPreferencesLoader preferencesGeneralFolder ]) / 'github-cache')
				ensureCreateDirectory;
				yourself)