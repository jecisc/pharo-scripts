execution
execute
	| group |
	group := (self currentWorld windowsSatisfying: [ :w | w label = 'Iceberg Repositories' ])
		ifEmpty: [ | g |
			g := GroupWindowMorph new.
			(g openInWindowLabeled: 'Iceberg Repositories') extent: 1200 @ 800.
			g ]
		ifNotEmpty: [ :ws | 
			| window |
			window := ws first.
			window isMinimized
				ifTrue: [ window restore ]
				ifFalse: [ window activate ]. window paneMorphs first ].
	group addWindow: (IceTipWorkingCopyBrowser on: self repositoryModel) openWithSpec window