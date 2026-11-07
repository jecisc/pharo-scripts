"
I am a text area to take notes, saved in a file at each change.

My model is the file holding the notes. PharoNotesUtility gives me a file in the cache folder of the playground so that the notes are shared between all my images.

The notes are read when I am built. If another image changes them while I am displayed, my next change overwrites its version.
"
Class {
	#name : 'PharoNotesPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'file',
		'textArea'
	],
	#category : 'PharoSettings-Utilities',
	#package : 'PharoSettings-Utilities'
}

{ #category : 'layout' }
PharoNotesPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: textArea;
		  yourself
]

{ #category : 'initialization' }
PharoNotesPresenter >> initializePresenters [

	textArea := self newText
		            placeholder: 'Write your notes here. They are shared between your images.';
		            text: (file exists
				             ifTrue: [ file contents ]
				             ifFalse: [ '' ]);
		            yourself.
	textArea whenTextChangedDo: [ :text | self save: text asString ]
]

{ #category : 'private' }
PharoNotesPresenter >> save: aString [
	"A write stream does not truncate an existing file, so the previous notes are deleted first."

	file parent ensureCreateDirectory.
	file ensureDelete.
	file writeStreamDo: [ :stream | stream nextPutAll: aString ]
]

{ #category : 'accessing - model' }
PharoNotesPresenter >> setModelBeforeInitialization: aFileReference [

	file := aFileReference
]

{ #category : 'accessing' }
PharoNotesPresenter >> textArea [

	^ textArea
]
