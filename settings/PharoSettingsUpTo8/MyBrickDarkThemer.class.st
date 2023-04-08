Class {
	#name : #MyBrickDarkThemer,
	#superclass : #GLMBrickThemer,
	#category : #PharoSettingsUpTo8
}

{ #category : #'as yet unclassified' }
MyBrickDarkThemer >> spotterThemer [

	^ self
		registerModule: MySpotterWidgetDarkThemer new
		to: GTSpotterBrickDarkThemer new
]

{ #category : #brick }
MyBrickDarkThemer >> textColor [
	^ Color white
]

{ #category : #brick }
MyBrickDarkThemer >> textSecondaryColor [
	^ Color white darker darker
]
