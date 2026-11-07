"
I am a utility of the utilities bar listing the Iceberg repositories of the image, the modified ones first (see PharoRepositoriesPresenter).
My presenter only follows the changes of the repositories while my panel is displayed.
"
Class {
	#name : 'PharoRepositoriesUtility',
	#superclass : 'UtilitiesBarUtility',
	#instVars : [
		'presenter'
	],
	#category : 'PharoSettings-Utilities',
	#package : 'PharoSettings-Utilities'
}

{ #category : 'events' }
PharoRepositoriesUtility >> displayed [

	presenter ifNotNil: [ :repositoriesPresenter | repositoriesPresenter startFollowing ]
]

{ #category : 'events' }
PharoRepositoriesUtility >> hidden [

	presenter ifNotNil: [ :repositoriesPresenter | repositoriesPresenter stopFollowing ]
]

{ #category : 'building' }
PharoRepositoriesUtility >> newPresenter [

	^ presenter := PharoRepositoriesPresenter new
]

{ #category : 'accessing' }
PharoRepositoriesUtility >> presenter [

	^ presenter
]

{ #category : 'accessing' }
PharoRepositoriesUtility >> priority [

	^ 40
]

{ #category : 'accessing' }
PharoRepositoriesUtility >> title [

	^ 'Repositories'
]
