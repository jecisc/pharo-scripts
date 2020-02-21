recentwindows
openCommonTools
	<name: #'Open common tools'>
	| group |
	group := GroupWindowMorph new
		addWindow: MCWorkingCopyBrowser new show;
		addWindow: GTPlayground open;
		addWindow: Transcript open;
		addWindow: TestRunner open.
	group tabGroup selectedPageIndex: 1.
	(group openInWindowLabeled: 'Common Tools') expandBoxHit