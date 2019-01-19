seaside
templateAddFileToLibraryFromURL
	<name: #'_Template: URL to file library'>
	GTPlayground openContents: 'library := SYNFileLibrary.
url := ''http://synectique.eu/images/ada.png''.
fileName := ''ada.png''.

library addFileNamed: fileName contents: (ZnEasy get: url) contents'