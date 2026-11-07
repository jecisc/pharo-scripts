"
I replace an Iceberg repository in the tests of PharoRepositoriesPresenter.
"
Class {
	#name : 'PharoFakeRepository',
	#superclass : 'Object',
	#instVars : [
		'name',
		'location',
		'modifiedPackages',
		'missing',
		'headDescription',
		'modifiedWithoutKnownPackages'
	],
	#category : 'PharoSettings-Utilities-Tests',
	#package : 'PharoSettings-Utilities-Tests'
}

{ #category : 'instance creation' }
PharoFakeRepository class >> named: aString at: aPathString head: aHeadDescription modifiedPackages: anInteger [

	^ self new
		  setName: aString
		  location: (aPathString ifNotNil: [ :path | FileSystem memory root resolve: path ])
		  headDescription: aHeadDescription
		  modifiedPackages: (1 to: anInteger) asArray;
		  yourself
]

{ #category : 'initialization' }
PharoFakeRepository >> beMissing [

	missing := true
]

{ #category : 'initialization' }
PharoFakeRepository >> beModifiedWithoutKnownPackages [

	modifiedWithoutKnownPackages := true
]

{ #category : 'accessing' }
PharoFakeRepository >> headDescription [

	^ headDescription
]

{ #category : 'accessing' }
PharoFakeRepository >> isMissing [

	^ missing
]

{ #category : 'accessing' }
PharoFakeRepository >> isModified [

	^ modifiedPackages isNotEmpty or: [ modifiedWithoutKnownPackages ]
]

{ #category : 'accessing' }
PharoFakeRepository >> location [

	^ location
]

{ #category : 'accessing' }
PharoFakeRepository >> modifiedPackages [

	^ modifiedPackages
]

{ #category : 'accessing' }
PharoFakeRepository >> name [

	^ name
]

{ #category : 'initialization' }
PharoFakeRepository >> setName: aString location: aFileReference headDescription: aHeadDescription modifiedPackages: aCollection [

	name := aString.
	location := aFileReference.
	headDescription := aHeadDescription.
	modifiedPackages := aCollection.
	missing := false.
	modifiedWithoutKnownPackages := false
]
