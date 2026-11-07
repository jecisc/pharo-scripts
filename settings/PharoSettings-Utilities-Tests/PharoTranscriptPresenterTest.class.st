"
I test PharoTranscriptPresenter and PharoTranscriptUtility on a transcript of my own, so that the Transcript of the image is not changed.
"
Class {
	#name : 'PharoTranscriptPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'transcript',
		'presenter'
	],
	#category : 'PharoSettings-Utilities-Tests',
	#package : 'PharoSettings-Utilities-Tests'
}

{ #category : 'running' }
PharoTranscriptPresenterTest >> setUp [

	super setUp.
	transcript := StThreadSafeTranscript new.
	presenter := PharoTranscriptPresenter on: transcript
]

{ #category : 'running' }
PharoTranscriptPresenterTest >> tearDown [

	presenter stopFollowing.
	super tearDown
]

{ #category : 'tests' }
PharoTranscriptPresenterTest >> testClearEmptiesTheTranscript [

	transcript show: 'hello'.
	presenter refresh.
	presenter clear.
	self assert: transcript contents equals: ''.
	self assert: presenter textArea text asString equals: ''
]

{ #category : 'tests' }
PharoTranscriptPresenterTest >> testDisplayedUtilityFollowsTheTranscript [

	| utility |
	utility := PharoTranscriptUtility new.
	utility buildContent.
	[
		utility displayed.
		self assert: utility presenter isFollowing ] ensure: [ utility hidden ]
]

{ #category : 'tests' }
PharoTranscriptPresenterTest >> testDoesNotFollowByDefault [

	self deny: presenter isFollowing
]

{ #category : 'tests' }
PharoTranscriptPresenterTest >> testHiddenUtilityStopsFollowing [

	| utility |
	utility := PharoTranscriptUtility new.
	utility buildContent.
	utility displayed.
	utility hidden.
	self deny: utility presenter isFollowing
]

{ #category : 'tests' }
PharoTranscriptPresenterTest >> testRefreshDisplaysTheContentsOfTheTranscript [

	transcript show: 'hello'.
	presenter refresh.
	self assert: presenter textArea text asString equals: 'hello'
]

{ #category : 'tests' }
PharoTranscriptPresenterTest >> testStartFollowingDisplaysTheCurrentContents [

	transcript show: 'hello'.
	presenter startFollowing.
	self assert: presenter isFollowing.
	self assert: presenter textArea text asString equals: 'hello'
]

{ #category : 'tests' }
PharoTranscriptPresenterTest >> testStopFollowing [

	presenter startFollowing.
	presenter stopFollowing.
	self deny: presenter isFollowing
]
