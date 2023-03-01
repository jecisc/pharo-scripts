Class {
	#name : #PharoCommonSettingsUpTo7,
	#superclass : #PharoAbstractSettings,
	#category : 'PharoSettingsUpTo7'
}

{ #category : #initialization }
PharoCommonSettingsUpTo7 class >> debuggerUpdate [
	"full debugger is the defaul in Pharo 8."

	<script>
	Smalltalk tools debugger alwaysOpenFullDebugger: true
]

{ #category : #'class initialization' }
PharoCommonSettingsUpTo7 class >> initialize [
	self
		setUsageData;
		debuggerUpdate;
		installNativeBrowser
]

{ #category : #initialization }
PharoCommonSettingsUpTo7 class >> installNativeBrowser [
	<script>
	| sourcesDir |
	self flag: #pharo5.
	SystemVersion current major < 6 ifTrue: [ ^ self ].
	sourcesDir := self sharedRepositoryFolder / 'jecisc' / 'Native-Browser' / 'src'.

	sourcesDir exists
		ifTrue: [ Metacello new
				repository: 'tonel://' , sourcesDir fullName;
				baseline: 'NativeBrowser';
				load ]
		ifFalse: [ (UIManager default questionWithoutCancel: 'Clone Native-Browser?')
				ifTrue: [ Metacello new
						githubUser: 'jecisc'
							project: 'Native-Browser'
							commitish: 'master'
							path: 'src';
						baseline: 'NativeBrowser';
						load ] ]
]

{ #category : #initialization }
PharoCommonSettingsUpTo7 class >> setUsageData [
	<script>
	Privacy
		sendDiagnosticsAndUsageData: true;
		sendEntityNames: false;
		sendSourceCode: false
]

{ #category : #'see class side' }
PharoCommonSettingsUpTo7 >> seeClassSide [
]
