as yet unclassified
templateToAddFileToLibraryFromURL
	<script>
	self
		open:
			'library := SYNFileLibrary.
url := ''http://synectique.eu/images/ada.png''.
fileName := ''ada.png''.

library addFileNamed: fileName contents: (ZnEasy get: url) contents'