"
I am a utility of the utilities bar to take notes (see PharoNotesPresenter).
The notes are saved in the cache folder of the playground, which my settings share between all my images (see PharoCommonSettings class >> #setPlaygroundFolder).
"
Class {
	#name : 'PharoNotesUtility',
	#superclass : 'UtilitiesBarUtility',
	#category : 'PharoSettings-Utilities',
	#package : 'PharoSettings-Utilities'
}

{ #category : 'building' }
PharoNotesUtility >> newPresenter [

	^ PharoNotesPresenter on: self notesFile
]

{ #category : 'accessing' }
PharoNotesUtility >> notesFile [
	"The cache folder of the playground is shared between my images."

	^ StPlayground cacheDirectory / 'notes.md'
]

{ #category : 'accessing' }
PharoNotesUtility >> priority [

	^ 20
]

{ #category : 'accessing' }
PharoNotesUtility >> title [

	^ 'Notes'
]
