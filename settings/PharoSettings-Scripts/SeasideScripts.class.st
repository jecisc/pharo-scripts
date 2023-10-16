"
A bunch on scripts seaside.
"
Class {
	#name : 'SeasideScripts',
	#superclass : 'Scripts',
	#category : 'PharoSettings-Scripts',
	#package : 'PharoSettings-Scripts'
}

{ #category : 'as yet unclassified' }
SeasideScripts class >> enableInImageDebugger [
	<script>
	self class environment
		at: #WAApplication
		ifPresent: [ :class | class allInstancesDo: [ :app | app exceptionHandler: (Smalltalk at: #WADebugErrorHandler) ] ]
		ifAbsent: [ self error: 'Seaside dev not loaded' ]
]

{ #category : 'as yet unclassified' }
SeasideScripts class >> startOn8080 [
	<script>
	(self class environment at: #ZnZincServerAdaptor) startOn: 8080
]

{ #category : 'as yet unclassified' }
SeasideScripts class >> startOn8080AndEnableInImageDebugger [
	<script>
	self
		startOn8080;
		enableInImageDebugger
]

{ #category : 'as yet unclassified' }
SeasideScripts class >> stopAdaptors [
	<script>
	(self class environment at: #WAServerAdaptor) allSubInstances do: #stop
]

{ #category : 'as yet unclassified' }
SeasideScripts class >> templateToAddFileToLibraryFromURL [
	<script>
	self
		open:
			'library := SYNFileLibrary.
url := ''http://synectique.eu/images/ada.png''.
fileName := ''ada.png''.

library addFileNamed: fileName contents: (ZnEasy get: url) contents'
]
