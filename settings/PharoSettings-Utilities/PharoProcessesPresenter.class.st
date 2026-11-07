"
I display the memory of the image, its garbage collections and its processes. The dot of a process is green when it runs or is ready to run, gray when it waits (the normal state of most processes), and orange when it is suspended, which is often the case of a process stopped in a debugger.
Buttons collect the garbage and terminate the selected process.

I only refresh myself between #startRefreshing and #stopRefreshing, every two seconds, so that I do not slow down the image while hidden: PharoProcessesUtility starts refreshing when its panel is displayed in the utilities bar and stops when it is hidden. Listing the processes scans the memory (Process allSubInstances), which is why it is not done more often.
"
Class {
	#name : 'PharoProcessesPresenter',
	#superclass : 'SpPresenter',
	#traits : 'TPharoStatusDot',
	#classTraits : 'TPharoStatusDot classTrait',
	#instVars : [
		'memoryLabel',
		'garbageCollectionsLabel',
		'processesList',
		'collectGarbageButton',
		'terminateButton',
		'refreshProcess'
	],
	#category : 'PharoSettings-Utilities',
	#package : 'PharoSettings-Utilities'
}

{ #category : 'testing' }
PharoProcessesPresenter >> canTerminate: aProcess [
	"Terminating the current process or the UI process would break the image."

	^ aProcess ~~ Processor activeProcess and: [ aProcess ~~ UIManager default uiProcess ]
]

{ #category : 'actions' }
PharoProcessesPresenter >> collectGarbage [

	Smalltalk garbageCollect.
	self refresh
]

{ #category : 'layout' }
PharoProcessesPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  spacing: 4;
		  add: memoryLabel expand: false;
		  add: garbageCollectionsLabel expand: false;
		  add: processesList;
		  add: (SpBoxLayout newLeftToRight
				   spacing: 4;
				   add: collectGarbageButton;
				   add: terminateButton;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : 'displaying' }
PharoProcessesPresenter >> dotColorFor: aProcess [
	"Green when the process runs or is ready to run, gray when it waits (the normal state of most processes), orange when it is suspended."

	(#( #active #ready ) includes: aProcess state) ifTrue: [ ^ Color green ].
	^ aProcess state = #waiting
		  ifTrue: [ Color gray ]
		  ifFalse: [ Color orange ]
]

{ #category : 'initialization' }
PharoProcessesPresenter >> initializePresenters [

	memoryLabel := self newLabel.
	garbageCollectionsLabel := self newLabel.
	processesList := self newList
		                 display: [ :process | self labelFor: process ];
		                 displayIcon: [ :process | self dotFor: process ];
		                 whenSelectionChangedDo: [ :selection | terminateButton enabled: (selection selectedItem isNotNil and: [ self canTerminate: selection selectedItem ]) ];
		                 yourself.
	collectGarbageButton := self newButton
		                        label: 'Collect garbage';
		                        icon: (self iconNamed: #smallDelete);
		                        action: [ self collectGarbage ];
		                        yourself.
	terminateButton := self newButton
		                   label: 'Terminate';
		                   icon: (self iconNamed: #stop);
		                   help: 'Terminate the selected process';
		                   enabled: false;
		                   action: [ self terminateSelectedProcess ];
		                   yourself.
	self refresh
]

{ #category : 'testing' }
PharoProcessesPresenter >> isRefreshing [

	^ refreshProcess isNotNil
]

{ #category : 'displaying' }
PharoProcessesPresenter >> labelFor: aProcess [

	^ '{1} (priority {2}, {3})' format: {
			  (aProcess name ifNil: [ 'unnamed' ]).
			  aProcess priority.
			  aProcess state }
]

{ #category : 'displaying' }
PharoProcessesPresenter >> megabytes: aNumberOfBytes [

	^ (aNumberOfBytes / (1024 * 1024) printShowingDecimalPlaces: 1) , ' MB'
]

{ #category : 'displaying' }
PharoProcessesPresenter >> processes [
	"The live processes, the most urgent first. Listing them scans the memory, see the class comment."

	^ (Process allSubInstances reject: [ :process | process isTerminated ]) sorted: [ :left :right |
			  left priority = right priority
				  ifTrue: [ (left name ifNil: [ '' ]) <= (right name ifNil: [ '' ]) ]
				  ifFalse: [ left priority > right priority ] ]
]

{ #category : 'actions' }
PharoProcessesPresenter >> refresh [
	"Keep the selected process selected if it still lives."

	| vm selectedProcess processes |
	vm := Smalltalk vm.
	memoryLabel label: ('Memory: {1} (old space {2}, {3} free)' format: {
				 (self megabytes: vm memorySize).
				 (self megabytes: vm oldSpace).
				 (self megabytes: vm freeOldSpaceSize) }).
	garbageCollectionsLabel label: ('Garbage collections: {1} full, {2} incremental' format: {
				 vm fullGCCount.
				 vm incrementalGCCount }).
	selectedProcess := processesList selectedItem.
	processes := self processes.
	processesList items: processes.
	(processes includes: selectedProcess) ifTrue: [ processesList selectItem: selectedProcess ]
]

{ #category : 'actions' }
PharoProcessesPresenter >> startRefreshing [
	"Refresh every two seconds in a background process. The refresh itself happens in the UI process."

	self isRefreshing ifTrue: [ ^ self ].
	refreshProcess := [
		                  [
			                  UIManager default defer: [ self refresh ].
			                  (Delay forSeconds: 2) wait ] repeat ] forkAt: Processor userBackgroundPriority named: 'Utilities bar processes refresh'
]

{ #category : 'actions' }
PharoProcessesPresenter >> stopRefreshing [

	refreshProcess ifNotNil: [ :process | process terminate ].
	refreshProcess := nil
]

{ #category : 'actions' }
PharoProcessesPresenter >> terminateSelectedProcess [

	| process |
	process := processesList selectedItem.
	(process isNil or: [ (self canTerminate: process) not ]) ifTrue: [ ^ self ].
	(self confirm: ('Terminate the process {1}?' format: { (self labelFor: process) })) ifFalse: [ ^ self ].
	process terminate.
	self refresh
]
