Class {
	#name : #Pharo5Settings,
	#superclass : #Object,
	#category : 'PharoSettings5-Specific'
}

{ #category : #initialization }
Pharo5Settings class >> fixBug [

	<script>
	GLMMorphicActionRenderer compile:
		((GLMMorphicActionRenderer >> #render:) sourceCode copyReplaceAll: 'setBalloonText: (anAction title' with: 'setBalloonText: (anAction title asString')
]

{ #category : #initialization }
Pharo5Settings class >> initialize [
	self fixBug
]
