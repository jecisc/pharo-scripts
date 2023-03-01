Class {
	#name : #Pharo7CommonSettings,
	#superclass : #PharoAbstractSettings,
	#category : 'PharoSettings7'
}

{ #category : #initialization }
Pharo7CommonSettings class >> addIcebergHack [
	"Add a hack to fetch a project if a commit is not found."

	<script>
	(IceGitCommit >> #project) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #projectAlt;
				control: #instead).

	"In the «New branch from issue» panel of Iceberg, select origin as remote all the time and not mine or another remote.
	In P9 the method was renamed."
	(IceGitHubNewBranchFromIssuePanel
		>>
			(SystemVersion current major < 9
				ifTrue: [ #initializeWidgetsContents ]
				ifFalse: [ #initializePresenters ])) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #selectOrigin;
				control: #after)
]

{ #category : #initialization }
Pharo7CommonSettings class >> disableSampleInstance [
	<script>
	(ClySampleInstanceScript >> #executeOn:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #executeOnAlt:;
				arguments: #(#arguments);
				control: #instead)
]

{ #category : #initialization }
Pharo7CommonSettings class >> icebergSettingsForP7Plus [

	<script>
	| creds file |
	file := self resourcesFolder / 'CredsIceberg'.
	file exists ifFalse: [
		file writeStreamDo: [ :s |
			s nextPutAll: (STON toStringPretty:
					 (Dictionary with: #username -> (UIManager default textEntry: 'Username') with: #password -> (UIManager default requestPassword: 'Password'))) ] ].
	creds := STON fromString: file contents.

	IceCredentialStore current
		storeCredential: (IcePlaintextCredentials new
				 username: (creds at: #username);
				 password: (creds at: #password);
				 yourself)
		forHostname: 'github.com'.

	"Open Iceberg. I often need it."
	SystemVersion current major < 10
		ifTrue: [ IceTipRepositoriesBrowser new openWithSpec ]
		ifFalse: [ IceTipRepositoriesBrowser new open ]
]

{ #category : #initialization }
Pharo7CommonSettings class >> initialize [
	self
		addIcebergHack;
		prepareForPharoContribution;
		icebergSettingsForP7Plus;
		disableSampleInstance;
		resetMenuBar;
		removeSomeRules
]

{ #category : #initialization }
Pharo7CommonSettings class >> prepareForPharoContribution [
	<script>
	(self imageNameBeginsWith: 'ContribPharo') ifFalse: [ ^ self ].

	IceRepository registry
		detect: [ :repo | repo workingCopy packages anySatisfy: [ :p | p name = 'BaselineOfPharo' ] ]
		ifFound: [ :pharoRepository |
			| defaultBranch |
			pharoRepository fetch.
			defaultBranch := 'Pharo' , SystemVersion current major asString , '.0'.

			pharoRepository branch name = defaultBranch ifTrue: [ ^ self ].

			"This mean that we are not on the default branch. Ask what to do."
			(UIManager default questionWithoutCancel: ('Currently on branch {1}. Want to switch to {2}?' format: {pharoRepository branch name . defaultBranch}))
				ifTrue: [ pharoRepository checkoutBranch: defaultBranch ] ]
]

{ #category : #removing }
Pharo7CommonSettings class >> removeSomeRules [
	<script>
	self flag: #todo. "Add a way to disable those if they are loaded *after* startup. Maybe register to the class added announcement?"
	#(#GRNonPortableSourceFormatRule #GRTestAssertionsRule #GRUsesCurlyBraceArraysRule #GRAnsiStreamsRule #GRAnsiExceptionsRule #GREmptyStatementsRule #GRInvalidObjectInitializationRule #GRUsesLiteralByteArraysRule #GRAnsiStringsRule #GRAnsiConvertorRule #GRObjectInRule #GRNonPortableMessageRule #GRAnsiConditionalsRule #GRAnsiBooleansRule #GRBasicNewInitializeMissingRule #GRAnsiCollectionsRule #GRUsesClassForHashRule #GRUsesCanPerformOrUnderstandRule #GRUsesNotPortableClassRule #GRNotPortableCollectionsRule #GRUsesMethodAnnotationsRule #GRAnsiCharactersRule)
		do: [ :each | self environment at: each ifPresent: [ :class | class enabled: false ] ].

	#(#RBShouldntRaiseErrorRule #ReShouldntRaiseErrorRule) do: [ :each | self environment at: each ifPresent: [ :class | class enabled: false ] ].

	ReRuleManager reset
]

{ #category : #initialization }
Pharo7CommonSettings class >> resetMenuBar [
	<script>
	"Needed to make scripts work."

	PharoQuickAccess resetMenubar
]

{ #category : #'see class side' }
Pharo7CommonSettings >> seeClassSide [
]
