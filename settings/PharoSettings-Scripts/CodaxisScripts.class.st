Class {
	#name : #CodaxisScripts,
	#superclass : #Scripts,
	#category : 'PharoSettings-Scripts'
}

{ #category : #parsing }
CodaxisScripts class >> launchParser [
	<script>
	self
		open:
			'PGTJavaImporter runCyrilExampleOnPixelController.

content := (FileLocator documents / ''Workspace'' / ''Java'' / ''PixelController-master'' / ''pixelcontroller-core\src\main\java\com\neophob\sematrix\core\generator\Blinkenlights.java'' ) asFileReference contents.

content := (FileLocator documents / ''Workspace'' / ''Java'' / ''PixelController-master'' / ''pixelcontroller-core\src\main\java\com\neophob\sematrix\core\generator\blinken\BlinkenImage.java'' ) asFileReference contents.


ast := PGTJavaGrammar parse: content.

PGTASTIMVisitor visit: ast.'
]

{ #category : #'see class side' }
CodaxisScripts >> seeClassSide [
]
