"
I test PharoNotesPresenter on a file of a memory file system.
"
Class {
	#name : 'PharoNotesPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'file'
	],
	#category : 'PharoSettings-Utilities-Tests',
	#package : 'PharoSettings-Utilities-Tests'
}

{ #category : 'running' }
PharoNotesPresenterTest >> setUp [

	super setUp.
	file := FileSystem memory root / 'notes.md'
]

{ #category : 'tests' }
PharoNotesPresenterTest >> testChangingTheTextSavesIt [

	| presenter |
	presenter := PharoNotesPresenter on: file.
	presenter textArea text: 'Call Steven'.
	self assert: file contents equals: 'Call Steven'
]

{ #category : 'tests' }
PharoNotesPresenterTest >> testDisplaysTheSavedNotes [

	file writeStreamDo: [ :stream | stream nextPutAll: 'Fix the CI' ].
	self assert: (PharoNotesPresenter on: file) textArea text asString equals: 'Fix the CI'
]

{ #category : 'tests' }
PharoNotesPresenterTest >> testIsEmptyWithoutSavedNotes [

	self assert: (PharoNotesPresenter on: file) textArea text asString equals: ''
]

{ #category : 'tests' }
PharoNotesPresenterTest >> testSavingReplacesThePreviousNotes [

	| presenter |
	file writeStreamDo: [ :stream | stream nextPutAll: 'A much longer previous note' ].
	presenter := PharoNotesPresenter on: file.
	presenter textArea text: 'Short'.
	self assert: file contents equals: 'Short'
]
