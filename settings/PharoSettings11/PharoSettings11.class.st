"
Settings for Pharo 11+
"
Class {
	#name : 'PharoSettings11',
	#superclass : 'PharoAbstractSettings',
	#category : 'PharoSettings11',
	#package : 'PharoSettings11'
}

{ #category : 'class initialization' }
PharoSettings11 class >> initialize [

	self spotterCustomizations
]

{ #category : 'class initialization' }
PharoSettings11 class >> spotterCustomizations [
	<script>

	StSpotter insertsSelection: false
]

{ #category : 'see class side' }
PharoSettings11 >> seeClassSide [
]
