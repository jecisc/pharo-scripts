"
I am a utility of the utilities bar displaying the Transcript (see PharoTranscriptPresenter).
My presenter only follows the Transcript while my panel is displayed, so that a hidden transcript does not slow down the image.
"
Class {
	#name : 'PharoTranscriptUtility',
	#superclass : 'UtilitiesBarUtility',
	#instVars : [
		'presenter'
	],
	#category : 'PharoSettings-Utilities',
	#package : 'PharoSettings-Utilities'
}

{ #category : 'events' }
PharoTranscriptUtility >> displayed [

	presenter ifNotNil: [ :transcriptPresenter | transcriptPresenter startFollowing ]
]

{ #category : 'events' }
PharoTranscriptUtility >> hidden [

	presenter ifNotNil: [ :transcriptPresenter | transcriptPresenter stopFollowing ]
]

{ #category : 'building' }
PharoTranscriptUtility >> newPresenter [

	^ presenter := PharoTranscriptPresenter on: Transcript
]

{ #category : 'accessing' }
PharoTranscriptUtility >> presenter [

	^ presenter
]

{ #category : 'accessing' }
PharoTranscriptUtility >> priority [

	^ 30
]

{ #category : 'accessing' }
PharoTranscriptUtility >> title [

	^ 'Transcript'
]
