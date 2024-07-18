Class {
	#name : 'PharoSettings13',
	#superclass : 'PharoAbstractSettings',
	#category : 'PharoSettings13',
	#package : 'PharoSettings13'
}

{ #category : 'class initialization' }
PharoSettings13 class >> initialize [
	self initializeTheme
]

{ #category : 'class initialization' }
PharoSettings13 class >> initializeTheme [

	<script>
	BlockStyler defaultThemes at: DarkBlueTheme put: (Color lightBlue alpha: 0.05).
	DarkBlueTheme beCurrent
]

{ #category : 'see class side' }
PharoSettings13 >> seeClassSide [
]
