recentwindows
groupWindowForGitReposWithPatter
	<name: 'Open group window with git repos using pattern'>
	| repos group |
	(UIManager default textEntry: 'Substring for the repos?')
		ifNotNil: [ :pattern | 
			repos := IceRepository registry select: [ :e | e name includesSubstring: pattern ].

			group := GroupWindowMorph new.

			repos do: [ :r | group addWindow: (IceTipWorkingCopyBrowser on: (IceTipRepositoryModel on: r) beCached) openWithSpec window ].
			group tabGroup selectedPageIndex: 1.
			(group openInWindowLabeled: 'Common repos') expandBoxHit ]