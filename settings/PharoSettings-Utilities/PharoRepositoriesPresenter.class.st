"
I list the Iceberg repositories of the image, the modified ones first, with a colored dot telling their state: orange when they have modified packages, green when clean, red when their clone is missing. Each repository is named by the two last folders of its location (its owner and its name on GitHub most of the time) since several repositories can have the same name.
Double clicking a repository opens its working copy in Iceberg.

I only follow the changes of the repositories between #startFollowing and #stopFollowing: PharoRepositoriesUtility starts following when its panel is displayed in the utilities bar and stops when it is hidden. While following, I listen to the announcements of Iceberg (sent for example each time a package of a repository changes) and the announcements received before the refresh happens in the UI process are coalesced into a single refresh.
"
Class {
	#name : 'PharoRepositoriesPresenter',
	#superclass : 'SpPresenter',
	#traits : 'TPharoStatusDot',
	#classTraits : 'TPharoStatusDot classTrait',
	#instVars : [
		'repositoriesList',
		'refreshButton',
		'following',
		'refreshScheduled'
	],
	#category : 'PharoSettings-Utilities',
	#package : 'PharoSettings-Utilities'
}

{ #category : 'actions' }
PharoRepositoriesPresenter >> browse: aRepository [

	aRepository ifNil: [ ^ self ].
	(IceTipWorkingCopyBrowser onRepository: aRepository) open
]

{ #category : 'layout' }
PharoRepositoriesPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  spacing: 4;
		  add: repositoriesList;
		  add: refreshButton expand: false;
		  yourself
]

{ #category : 'displaying' }
PharoRepositoriesPresenter >> dotColorFor: aRepository [

	aRepository isMissing ifTrue: [ ^ Color red ].
	^ aRepository isModified
		  ifTrue: [ Color orange ]
		  ifFalse: [ Color green ]
]

{ #category : 'displaying' }
PharoRepositoriesPresenter >> folderNameOf: aRepository [
	"Several repositories can have the same name, so the two last folders of their location are used: their owner and their name on GitHub most of the time."

	| location |
	location := aRepository location ifNil: [ ^ aRepository name ].
	^ '{1}/{2}' format: {
			  location parent basename.
			  location basename }
]

{ #category : 'initialization' }
PharoRepositoriesPresenter >> initialize [

	super initialize.
	following := false.
	refreshScheduled := false
]

{ #category : 'initialization' }
PharoRepositoriesPresenter >> initializePresenters [

	repositoriesList := self newList
		                    display: [ :repository | self labelFor: repository ];
		                    displayIcon: [ :repository | self dotFor: repository ];
		                    whenActivatedDo: [ :selection | self browse: selection selectedItem ];
		                    yourself.
	repositoriesList activateOnDoubleClick.
	refreshButton := self newButton
		                 label: 'Refresh';
		                 icon: (self iconNamed: #glamorousRefresh);
		                 action: [ self refresh ];
		                 yourself
]

{ #category : 'testing' }
PharoRepositoriesPresenter >> isFollowing [

	^ following
]

{ #category : 'displaying' }
PharoRepositoriesPresenter >> labelFor: aRepository [

	^ String streamContents: [ :stream |
			  stream
				  nextPutAll: (self folderNameOf: aRepository);
				  nextPutAll: ' ('.
			  aRepository isMissing
				  ifTrue: [ stream nextPutAll: 'missing' ]
				  ifFalse: [ self printStateOf: aRepository on: stream ].
			  stream nextPut: $) ]
]

{ #category : 'displaying' }
PharoRepositoriesPresenter >> printStateOf: aRepository on: aStream [
	"The description of the head is the name of the branch, or the tags or commit of a detached head. Iceberg can tell that a repository is modified without knowing its modified packages, for example when it does not know the commit the working copy comes from."

	| modifiedPackagesCount |
	aStream nextPutAll: aRepository headDescription.
	aRepository isModified ifFalse: [ ^ self ].
	modifiedPackagesCount := aRepository modifiedPackages size.
	modifiedPackagesCount isZero ifTrue: [ ^ aStream nextPutAll: ', modified' ].
	aStream
		nextPutAll: ', ';
		print: modifiedPackagesCount;
		nextPutAll: ' modified package'.
	modifiedPackagesCount > 1 ifTrue: [ aStream nextPut: $s ]
]

{ #category : 'actions' }
PharoRepositoriesPresenter >> refresh [

	repositoriesList items: (self sorted: IceRepository registry)
]

{ #category : 'private' }
PharoRepositoriesPresenter >> repositoriesChanged [
	"Iceberg announces a change for each modified package, so the announcements received before the refresh happens in the UI process are coalesced into a single refresh."

	refreshScheduled ifTrue: [ ^ self ].
	refreshScheduled := true.
	UIManager default defer: [
			refreshScheduled := false.
			following ifTrue: [ self refresh ] ]
]

{ #category : 'displaying' }
PharoRepositoriesPresenter >> sorted: aCollection [
	"The modified repositories first, then by name."

	^ aCollection asArray sorted: [ :left :right |
			  left isModified = right isModified
				  ifTrue: [ (self folderNameOf: left) asLowercase <= (self folderNameOf: right) asLowercase ]
				  ifFalse: [ left isModified ] ]
]

{ #category : 'actions' }
PharoRepositoriesPresenter >> startFollowing [

	following ifTrue: [ ^ self ].
	following := true.
	Iceberg announcer weak when: IceAnnouncement send: #repositoriesChanged to: self.
	self refresh
]

{ #category : 'actions' }
PharoRepositoriesPresenter >> stopFollowing [

	following := false.
	Iceberg announcer unsubscribe: self
]
