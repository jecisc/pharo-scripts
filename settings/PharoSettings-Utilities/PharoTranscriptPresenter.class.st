"
I display the contents of a transcript (StThreadSafeTranscript).

I only follow the transcript between #startFollowing and #stopFollowing, so that a hidden transcript does not slow down the image: PharoTranscriptUtility starts following when its panel is displayed in the utilities bar and stops when it is hidden.

While following, I listen to the announcements of new entries and of clearing. They are sent from the process of the transcript, so the refresh is deferred to the UI process, and the announcements received before it happens are coalesced into a single refresh.
"
Class {
	#name : 'PharoTranscriptPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'transcript',
		'textArea',
		'clearButton',
		'following',
		'refreshScheduled'
	],
	#category : 'PharoSettings-Utilities',
	#package : 'PharoSettings-Utilities'
}

{ #category : 'actions' }
PharoTranscriptPresenter >> clear [

	transcript clear.
	self refresh
]

{ #category : 'layout' }
PharoTranscriptPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  spacing: 4;
		  add: textArea;
		  add: clearButton expand: false;
		  yourself
]

{ #category : 'initialization' }
PharoTranscriptPresenter >> initialize [

	following := false.
	refreshScheduled := false.
	super initialize
]

{ #category : 'initialization' }
PharoTranscriptPresenter >> initializePresenters [

	textArea := self newText
		            beNotEditable;
		            yourself.
	clearButton := self newButton
		               label: 'Clear';
		               icon: (self iconNamed: #smallDelete);
		               action: [ self clear ];
		               yourself
]

{ #category : 'testing' }
PharoTranscriptPresenter >> isFollowing [

	^ following
]

{ #category : 'actions' }
PharoTranscriptPresenter >> refresh [
	"Display the contents of the transcript and scroll to its end. Spec has no API to scroll a text, so the Morphic widget is asked directly once it exists."

	textArea text: transcript contents.
	textArea withAdapterDo: [ :textAdapter | textAdapter widgetDo: [ :widget | widget scrollToEndOfText ] ]
]

{ #category : 'accessing - model' }
PharoTranscriptPresenter >> setModelBeforeInitialization: aTranscript [

	transcript := aTranscript
]

{ #category : 'actions' }
PharoTranscriptPresenter >> startFollowing [

	following ifTrue: [ ^ self ].
	following := true.
	SystemAnnouncer uniqueInstance weak when: NewEntryToTranscript , ClearTranscript send: #transcriptChanged to: self.
	self refresh
]

{ #category : 'actions' }
PharoTranscriptPresenter >> stopFollowing [

	following := false.
	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : 'accessing' }
PharoTranscriptPresenter >> textArea [

	^ textArea
]

{ #category : 'private' }
PharoTranscriptPresenter >> transcriptChanged [
	"Sent from the process of the transcript for each new entry. The refresh happens in the UI process, once for all the entries received before it."

	refreshScheduled ifTrue: [ ^ self ].
	refreshScheduled := true.
	UIManager default defer: [
			refreshScheduled := false.
			following ifTrue: [ self refresh ] ]
]
