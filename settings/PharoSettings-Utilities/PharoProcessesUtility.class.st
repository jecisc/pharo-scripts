"
I am a utility of the utilities bar displaying the memory and the processes of the image (see PharoProcessesPresenter).
My presenter only refreshes itself while my panel is displayed.
"
Class {
	#name : 'PharoProcessesUtility',
	#superclass : 'UtilitiesBarUtility',
	#instVars : [
		'presenter'
	],
	#category : 'PharoSettings-Utilities',
	#package : 'PharoSettings-Utilities'
}

{ #category : 'events' }
PharoProcessesUtility >> displayed [

	presenter ifNotNil: [ :processesPresenter | processesPresenter startRefreshing ]
]

{ #category : 'events' }
PharoProcessesUtility >> hidden [

	presenter ifNotNil: [ :processesPresenter | processesPresenter stopRefreshing ]
]

{ #category : 'building' }
PharoProcessesUtility >> newPresenter [

	^ presenter := PharoProcessesPresenter new
]

{ #category : 'accessing' }
PharoProcessesUtility >> presenter [

	^ presenter
]

{ #category : 'accessing' }
PharoProcessesUtility >> priority [

	^ 50
]

{ #category : 'accessing' }
PharoProcessesUtility >> title [

	^ 'Processes'
]
