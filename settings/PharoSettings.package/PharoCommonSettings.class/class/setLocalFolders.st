initialization
setLocalFolders
	<script>
	MCCacheRepository
		cacheDirectory:
			((self rootFolder / 'package-cache')
				ensureCreateDirectory;
				yourself).
	MCGitHubRepository
		cacheDirectory:
			(((OSPlatform current isWindows
				ifTrue: [ FileLocator C	"This is a hack to shorten windows's paths because windows have a max path of 255 characters :(" ]
				ifFalse: [ self rootFolder ]) / 'github-cache')
				ensureCreateDirectory;
				yourself)