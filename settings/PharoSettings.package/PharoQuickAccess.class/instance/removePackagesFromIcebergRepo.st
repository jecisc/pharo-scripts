templates
removePackagesFromIcebergRepo
	<name: #'Remove packages from iceberg repo'>
	GTPlayground
		openContents:
			'(IceRepository registry detect: [ :e | e name = ''Fame'' ]) workingCopy packages reject: [ :p | p name includesSubstring: ''Fame'' ] thenDo: #remove'