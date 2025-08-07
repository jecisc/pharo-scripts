Extension { #name : 'Object' }

{ #category : '*PharoSettings' }
Object >> compileGetterNamed: var in: class [

	class
		compile: (String streamContents: [ :s |
					 s
						 << var;
						 cr;
						 << Character tab;
						 << '^ ';
						 << var ])
		classified: 'accessing'.
	self inform: 'Compiled: ' , var , ' into: ' , class printString
]

{ #category : '*PharoSettings' }
Object >> compileSetterNamed: message returning: var in: class [

	class
		compile: (String streamContents: [ :s |
					 s
						 << message;
						 << ' anObject';
						 << String cr;
						 << Character tab;
						 << var;
						 << ' := anObject' ])
		classified: 'accessing'.
	self inform: 'Compiled: ' , message , ' into: ' , class printString
]

{ #category : '*PharoSettings' }
Object >> generatesPotentialSetterOrGetterWith: anArray context: context [

	<debuggerCompleteToSender>
	| message aMessage selectorsToIgnore |
	"In some cases I want to not generate the accessors."
	selectorsToIgnore := #( 'buttonPresenter' 'subpresenter1' 'subpresenter2' 'subpresenter3' 'subpresenter4' ). "This one is in a Spec Mock to test usage of the Interpreter when there is no getter. So I do not want to generate a getter for the test. Remove when I will not work on Spec anymore."

	aMessage := anArray anyOne.
	message := aMessage selector asString.
	(selectorsToIgnore includes: message) ifTrue: [ ^ self ].
	(self class allSuperclasses anySatisfy: [ :c | c name = #PP2CompositeNode ]) ifTrue: [ ^ self ].
	self class withAllSuperclassesDo: [ :class |
			message last = $:
				ifTrue: [
						class instVarNames
							detect: [ :var | var = message allButLast ]
							ifFound: [ :var |
									self compileSetterNamed: message returning: var in: class.
									context return: (aMessage sentTo: self) ] ]
				ifFalse: [
						class instVarNames
							detect: [ :var | var = message ]
							ifFound: [ :var |
									self compileGetterNamed: var in: class.
									context return: (aMessage sentTo: self) ] ] ]
]

{ #category : '*PharoSettings' }
Object >> h [
	"This is the typical message to use for inserting breakpoints during debugging."

	<debuggerCompleteToSender>
	Halt now
]

{ #category : '*PharoSettings' }
Object >> haltOnceIf: aBlock [
	"This is the typical message to use for inserting breakpoints during debugging."

	<debuggerCompleteToSender>
	(aBlock cull: self) ifTrue: [ self haltOnce ]
]

{ #category : '*PharoSettings' }
Object >> storeIn: aSymbol [
	self class environment at: aSymbol put: self
]

{ #category : '*PharoSettings' }
Object >> toKill [
	self flag: #toKill.
	('Method to kill ' , thisContext sender method printString , ' called by ' , thisContext sender sender method printString) logCr
]

{ #category : '*PharoSettings' }
Object >> todo [
	"If it is not enabled, do not block the flow. I'll see later to implements those features."

	OwO isTodoEnabled ifTrue: [ self shouldBeImplemented ]
]
