"
Description
--------------------

I am an utility holding the latest closed windows and allowing one to open them again.

By default I keep 10 windows but this number can change.

I will flush the windows when we quit the image.

Public API and Key Messages
--------------------

- #restoreWindow 		Allows one to restore a window.
- #flush 					Flush the currently kept windows.

Examples
--------------------

	RecentlyClosedWindowsSaver default restoreWindow.
	
	RencentlyClosedWindowsSaver default numberOfWindowsToKeep: 15.
	
	RencentlyClosedWindowsSaver default flush.
	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	cache:		<aLRUCache>		Cache keeping the latest 10 windows.

"
Class {
	#name : #RecentlyClosedWindowsSaver,
	#superclass : #Object,
	#instVars : [
		'cache'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #PharoSettings
}

{ #category : #accessing }
RecentlyClosedWindowsSaver class >> default [
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #'class initialization' }
RecentlyClosedWindowsSaver class >> initialize [
	SessionManager default registerUserClassNamed: self name.
	self startUp: true.
	self setCalypsoMetaLink
]

{ #category : #'class initialization' }
RecentlyClosedWindowsSaver class >> reset [
	<script>
	UniqueInstance := nil
]

{ #category : #'class initialization' }
RecentlyClosedWindowsSaver class >> setCalypsoMetaLink [
	"When a Calypso window is closing, it is removing its content making it impossible to open again the window.
	To work around the problem I use a metalink to not remove the content."

	<script>
	self environment
		at: #ClyBrowserMorph
		ifPresent: [ :class |
			(class >> #windowIsClosing) sourceCode
				=
					'windowIsClosing

	navigationViews do: [ :each | each windowIsClosing ].
	tabManager windowIsClosing.
	self window ifNotNil: [ :w |
		w
			removeMorph: self;
			updatePanesFromSubmorphs;
			model: nil]'
				ifTrue: [ class
						compiledMethodAt: #altWindowIsClosing
						ifAbsent: [ class
								compile:
									'altWindowIsClosing
	navigationViews do: [ :each | each windowIsClosing ].
	tabManager windowIsClosing'
								classified: '*' , self package name ].


					(class >> #windowIsClosing) ast
						link:
							(MetaLink new
								metaObject: #receiver;
								selector: #altWindowIsClosing;
								control: #instead) ] ]
]

{ #category : #'system startup' }
RecentlyClosedWindowsSaver class >> shutDown: isImageQuitting [
	isImageQuitting ifTrue: [ self reset ]
]

{ #category : #'system startup' }
RecentlyClosedWindowsSaver class >> startUp: isImageStarting [
	isImageStarting ifTrue: [ self default ]
]

{ #category : #actions }
RecentlyClosedWindowsSaver >> flush [
	cache removeAll
]

{ #category : #initialization }
RecentlyClosedWindowsSaver >> initialize [
	super initialize.
	cache := LRUCache new.
	self numberOfWindowsToKeep: 10.
	self currentWorld announcer when: WindowClosed do: [ :ann | cache at: DateAndTime now put: ann window ]
]

{ #category : #accessing }
RecentlyClosedWindowsSaver >> numberOfWindowsToKeep: anInteger [
	cache maximumWeight: anInteger
]

{ #category : #printing }
RecentlyClosedWindowsSaver >> printYMDHMS: aDate [
	^ String
		streamContents: [ :s |
			aDate printYMDOn: s.
			s space.
			aDate printHMSOn: s ]
]

{ #category : #actions }
RecentlyClosedWindowsSaver >> restoreWindow [
	| labels values |
	labels := OrderedCollection new.
	values := OrderedCollection new.

	cache
		keysAndValuesDo: [ :date :window |
			labels add: (self printYMDHMS: date) , ' ' , window label.
			values add: window ].

	(UIManager default chooseFrom: labels values: values) ifNotNil: [ :window | window openInWorld ]
]
