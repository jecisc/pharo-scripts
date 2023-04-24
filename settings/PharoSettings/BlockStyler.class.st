"
A class to highlight block and visualize better imbricated blocks.
"
Class {
	#name : #BlockStyler,
	#superclass : #IconStyler,
	#instVars : [
		'nesting'
	],
	#classVars : [
		'DefaultThemes',
		'Enabled'
	],
	#category : #PharoSettings
}

{ #category : #defaults }
BlockStyler class >> defaultBackgroundColor [
	^ self defaultThemes at: Smalltalk ui theme class ifPresent: [ :each | each ] ifAbsent: [ Smalltalk ui theme backgroundColor negated alpha: 0.15 ]
]

{ #category : #settings }
BlockStyler class >> defaultBackgroundColor: aColor [
	self defaultThemes at: Smalltalk ui theme class put: aColor
]

{ #category : #defaults }
BlockStyler class >> defaultThemes [
	^ DefaultThemes ifNil: [ DefaultThemes := Dictionary new ]
]

{ #category : #accessing }
BlockStyler class >> enabled [
	^ Enabled
		ifNil: [Enabled := true]
]

{ #category : #accessing }
BlockStyler class >> enabled: aBoolean [
	Enabled := aBoolean
]

{ #category : #testing }
BlockStyler class >> isStaticStyler [

	^ true
]

{ #category : #defaults }
BlockStyler class >> resetDefaultThemes [
	DefaultThemes := nil
]

{ #category : #settings }
BlockStyler class >> settingsOn: aBuilder [
	<systemsettings>
	(aBuilder setting: #'BlockStyler')
		parent: #'Syntax Highlighting';
		target: self;
		selector: #enabled;
		with: [ (aBuilder setting: #defaultBackgroundColor) label: 'Background color' ]
]

{ #category : #adding }
BlockStyler >> addIconStyle: aNode from: start to: stop color: aColor [
	"not doing that like this"
]

{ #category : #accessing }
BlockStyler >> backgroundColor [
	^ self class defaultBackgroundColor
]

{ #category : #private }
BlockStyler >> backgroundLineLimits: aCollection [
	| backgroundLineLimits |
	backgroundLineLimits := aCollection withIndexCollect: [ :line :index | index = 1 ifTrue: [ line ] ifFalse: [ line key + nesting -> line value ] ].
	^ backgroundLineLimits select: [ :line | line value > line key ]
]

{ #category : #initialization }
BlockStyler >> initialize [
	super initialize.
	nesting := 0
]

{ #category : #private }
BlockStyler >> lineLimitsOf: aBlockNode [
	| text limits |
	limits := OrderedCollection new.
	[text := textModel text copyFrom: aBlockNode left to: aBlockNode right] on: Error do: [ text := ''].
	text string lineIndicesDo: [ :start :endWithout :endWith | limits add: start -> endWith ].
	^ limits
]

{ #category : #visiting }
BlockStyler >> visitBlockNode: aBlockNode [
	(SHPreferences enabled and: self class enabled) ifTrue: [ (self backgroundLineLimits: (self lineLimitsOf: aBlockNode)) do: [ :line | | change |
		change := RubConfigurationChange new.
		change configurationBlock: [ :t | | r |
			r := RubTextSegmentMorph from: aBlockNode left + line key - 1 to: aBlockNode left + line value.
			r color: self backgroundColor.
			t addSegment: r ].
		textModel announce: change ] ].
	nesting := nesting + 1.
	super visitBlockNode: aBlockNode.
	nesting := nesting - 1
]
