Class {
	#name : 'PharoSettings12',
	#superclass : 'PharoAbstractSettings',
	#category : 'PharoSettings12',
	#package : 'PharoSettings12'
}

{ #category : 'class initialization' }
PharoSettings12 class >> doNotSelectHashtagWhenSelectingSymbols [

	<script>
	(RubTextEditor >> #selectWord) ast link: (MetaLink new
			 metaObject: #receiver;
			 selector: #mySelectWord;
			 control: #instead)
]

{ #category : 'class initialization' }
PharoSettings12 class >> enableProjectViewOfCalypso [

	<script>
	"Disabled for now."
	"ClyFullBrowserMorph shouldDisplayProjectView: true"
]

{ #category : 'class initialization' }
PharoSettings12 class >> initialize [

	self
		doNotSelectHashtagWhenSelectingSymbols;
		enableProjectViewOfCalypso;
		registerUtilitiesBar
]

{ #category : 'actions' }
PharoSettings12 class >> installMCP [
	"Install the MCP server for Pharo from its local clone, or from GitHub if I agree to clone it."

	<script>
	| sourcesDirectory |
	sourcesDirectory := self sharedRepositoryFolder / 'Evref-BL' / 'MCP' / 'src'.
	sourcesDirectory exists
		ifTrue: [
				Metacello new
					repository: 'tonel://' , sourcesDirectory fullName;
					baseline: 'MCP';
					load ]
		ifFalse: [
				(UIManager default questionWithoutCancel: 'Clone MCP?') ifFalse: [ ^ self ].
				Metacello new
					githubUser: 'Evref-BL'
					project: 'MCP'
					commitish: 'main'
					path: 'src';
					baseline: 'MCP';
					load ].
	self registerIfPresentProjectOf: 'Evref-BL' named: 'MCP'
]

{ #category : 'class initialization' }
PharoSettings12 class >> registerUtilitiesBar [
	"The utilities bar is loaded by my baseline, from my local clone when there is one. Register the clone in Iceberg."

	<script>
	self registerIfPresentProjectOf: 'jecisc' named: 'pharo-utilities-bar'
]

{ #category : 'see class side' }
PharoSettings12 >> seeClassSide [
]
