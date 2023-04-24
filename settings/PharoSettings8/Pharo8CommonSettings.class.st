"
Settings for Pharo 8+
"
Class {
	#name : #Pharo8CommonSettings,
	#superclass : #PharoAbstractSettings,
	#category : #PharoSettings8
}

{ #category : #'class initialization' }
Pharo8CommonSettings class >> initialize [
	self installFlagBrowser
]

{ #category : #'class initialization' }
Pharo8CommonSettings class >> installFlagBrowser [
	<script>
	| sourcesDir |
	sourcesDir := self sharedRepositoryFolder / 'jecisc' / 'FlagBrowser' / 'src'.

	sourcesDir exists
		ifTrue: [ Metacello new
				repository: 'tonel://' , sourcesDir fullName;
				baseline: 'FlagBrowser';
				load ]
		ifFalse: [ (UIManager default questionWithoutCancel: 'Clone FlagBrowser?')
				ifTrue: [ Metacello new
						githubUser: 'jecisc'
							project: 'FlagBrowser'
							commitish: 'master'
							path: 'src';
						baseline: 'FlagBrowser';
						load ] ]
]

{ #category : #'see class side' }
Pharo8CommonSettings >> seeClassSide [
]
