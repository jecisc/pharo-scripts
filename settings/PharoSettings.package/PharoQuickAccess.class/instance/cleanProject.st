templates
cleanProject
	<name: #'Clean project'>
	GTPlayground
		openContents:
			'packages := ((IceRepository registry select: [ :e | e name = ''Moose'' ]) flatCollect: [ :e | e workingCopy packageNames collect: [:s | s asPackageIfAbsent: [ nil ] ]]) reject: #isNil..

CodeCleaner cleanPackages: packages'