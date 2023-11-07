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
		enableProjectViewOfCalypso
]

{ #category : 'see class side' }
PharoSettings12 >> seeClassSide [
]
