parsing
launchParser
	<script>
	self
		open:
			'PGTJavaImporter runCyrilExampleOnPixelController.

content := (FileLocator documents / ''Workspace'' / ''Java'' / ''PixelController-master'' / ''pixelcontroller-core\src\main\java\com\neophob\sematrix\core\generator\Blinkenlights.java'' ) asFileReference contents.

content := (FileLocator documents / ''Workspace'' / ''Java'' / ''PixelController-master'' / ''pixelcontroller-core\src\main\java\com\neophob\sematrix\core\generator\blinken\BlinkenImage.java'' ) asFileReference contents.


ast := PGTJavaGrammar parse: content.

PGTASTIMVisitor visit: ast.'