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
	ClyFullBrowserMorph shouldDisplayProjectView: true
]

{ #category : 'class initialization' }
PharoSettings12 class >> initialize [

	self
		doNotSelectHashtagWhenSelectingSymbols;
		installShoutTelemetry;
		enableProjectViewOfCalypso
]

{ #category : 'class initialization' }
PharoSettings12 class >> installShoutTelemetry [

	<script>
	| sourcesDir |
	sourcesDir := self sharedRepositoryFolder / 'Gabriel-Darbord' / 'opentelemetry-pharo' / 'src'.

	sourcesDir exists
		ifTrue: [
			Metacello new
				repository: 'tonel://' , sourcesDir fullName;
				baseline: 'OpenTelemetry';
				load: 'Shout' ]
		ifFalse: [
			(UIManager default questionWithoutCancel: 'Clone open telemetry?') ifTrue: [
				Metacello new
					githubUser: 'Gabriel-Darbord'
					project: 'opentelemetry-pharo'
					commitish: 'main'
					path: 'src';
					baseline: 'OpenTelemetry';
					load: 'Shout' ] ].

	OTSpanExporter instance folder: (self resourcesFolder / 'ShoutTelemetry') ensureCreateDirectory
]

{ #category : 'see class side' }
PharoSettings12 >> seeClassSide [
]
