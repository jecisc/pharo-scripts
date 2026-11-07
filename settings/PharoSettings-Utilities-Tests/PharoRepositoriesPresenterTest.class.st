"
I test how PharoRepositoriesPresenter displays repositories, using fake repositories.
"
Class {
	#name : 'PharoRepositoriesPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'PharoSettings-Utilities-Tests',
	#package : 'PharoSettings-Utilities-Tests'
}

{ #category : 'running' }
PharoRepositoriesPresenterTest >> setUp [

	super setUp.
	presenter := PharoRepositoriesPresenter basicNew
]

{ #category : 'tests' }
PharoRepositoriesPresenterTest >> testDisplayedUtilityFollowsTheRepositories [

	| utility |
	utility := PharoRepositoriesUtility new.
	utility buildContent.
	[
		utility displayed.
		self assert: utility presenter isFollowing ] ensure: [ utility hidden ].
	self deny: utility presenter isFollowing
]

{ #category : 'tests' }
PharoRepositoriesPresenterTest >> testDotIsGreenWhenClean [

	self
		assert: (presenter dotColorFor: (PharoFakeRepository
					  named: 'Bazard'
					  at: '/git/jecisc/Bazard'
					  head: 'master'
					  modifiedPackages: 0))
		equals: Color green
]

{ #category : 'tests' }
PharoRepositoriesPresenterTest >> testDotIsOrangeWhenModified [

	self
		assert: (presenter dotColorFor: (PharoFakeRepository
					  named: 'Bazard'
					  at: '/git/jecisc/Bazard'
					  head: 'master'
					  modifiedPackages: 2))
		equals: Color orange
]

{ #category : 'tests' }
PharoRepositoriesPresenterTest >> testDotIsRedWhenMissing [

	| repository |
	repository := PharoFakeRepository
		              named: 'Bazard'
		              at: '/git/jecisc/Bazard'
		              head: 'master'
		              modifiedPackages: 0.
	repository beMissing.
	self assert: (presenter dotColorFor: repository) equals: Color red
]

{ #category : 'tests' }
PharoRepositoriesPresenterTest >> testLabelGivesTheNumberOfModifiedPackages [

	self
		assert: (presenter labelFor: (PharoFakeRepository
					  named: 'pharo'
					  at: '/git/pharo-project/pharo'
					  head: 'Pharo15.0'
					  modifiedPackages: 1))
		equals: 'pharo-project/pharo (Pharo15.0, 1 modified package)'.
	self
		assert: (presenter labelFor: (PharoFakeRepository
					  named: 'pharo'
					  at: '/git/pharo-project/pharo'
					  head: 'Pharo15.0'
					  modifiedPackages: 3))
		equals: 'pharo-project/pharo (Pharo15.0, 3 modified packages)'
]

{ #category : 'tests' }
PharoRepositoriesPresenterTest >> testLabelGivesTheOwnerFolderAndTheBranch [

	self
		assert: (presenter labelFor: (PharoFakeRepository
					  named: 'Bazard'
					  at: '/git/jecisc/Bazard'
					  head: 'master'
					  modifiedPackages: 0))
		equals: 'jecisc/Bazard (master)'
]

{ #category : 'tests' }
PharoRepositoriesPresenterTest >> testLabelOfADetachedRepositoryGivesItsTags [

	self
		assert: (presenter labelFor: (PharoFakeRepository
					  named: 'JRPC'
					  at: '/git/Evref-BL/JRPC'
					  head: 'v4.0.1, v4.0.x'
					  modifiedPackages: 0))
		equals: 'Evref-BL/JRPC (v4.0.1, v4.0.x)'
]

{ #category : 'tests' }
PharoRepositoriesPresenterTest >> testLabelOfAMissingRepository [

	self
		assert: (presenter labelFor: ((PharoFakeRepository
					   named: 'Bazard'
					   at: '/git/jecisc/Bazard'
					   head: 'master'
					   modifiedPackages: 0)
					  beMissing;
					  yourself))
		equals: 'jecisc/Bazard (missing)'
]

{ #category : 'tests' }
PharoRepositoriesPresenterTest >> testLabelOfARepositoryModifiedWithoutKnownPackages [

	| repository |
	repository := PharoFakeRepository
		              named: 'Roassal'
		              at: '/git/pharo-graphics/Roassal'
		              head: 'Pharo14'
		              modifiedPackages: 0.
	repository beModifiedWithoutKnownPackages.
	self assert: (presenter labelFor: repository) equals: 'pharo-graphics/Roassal (Pharo14, modified)'
]

{ #category : 'tests' }
PharoRepositoriesPresenterTest >> testLabelWithoutLocationUsesTheName [

	self
		assert: (presenter labelFor: (PharoFakeRepository
					  named: 'Bazard'
					  at: nil
					  head: 'master'
					  modifiedPackages: 0))
		equals: 'Bazard (master)'
]

{ #category : 'tests' }
PharoRepositoriesPresenterTest >> testModifiedRepositoriesComeFirst [

	| clean modified other |
	clean := PharoFakeRepository
		         named: 'Bazard'
		         at: '/git/jecisc/Bazard'
		         head: 'master'
		         modifiedPackages: 0.
	modified := PharoFakeRepository
		            named: 'Zinc'
		            at: '/git/svenvc/zinc'
		            head: 'master'
		            modifiedPackages: 1.
	other := PharoFakeRepository
		         named: 'Alpha'
		         at: '/git/jecisc/Alpha'
		         head: 'master'
		         modifiedPackages: 0.
	self
		assert: (presenter sorted: {
					 clean.
					 modified.
					 other }) asArray
		equals: {
				modified.
				other.
				clean }
]
