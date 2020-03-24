templates
cleanProject
	<name: #'Clean project'>
	GTPlayground
		openContents:
			'packages := (IceRepository registry select: [ :e | e name includesSubstring: ''Codaxis'' ]) flatCollect: [ :e | e workingCopy packageNames collect: #asPackage ].

CodeCleaner cleanPackages: packages'