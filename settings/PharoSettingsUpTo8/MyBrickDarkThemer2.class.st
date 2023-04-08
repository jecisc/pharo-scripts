Class {
	#name : #MyBrickDarkThemer2,
	#superclass : #GLMBrickDarkThemer,
	#category : #PharoSettingsUpTo8
}

{ #category : #'as yet unclassified' }
MyBrickDarkThemer2 >> spotterThemer [

	^ self
		registerModule: MyGTSpotterWidgetDarkThemer new
		to: MyGTSpotterBrickDarkThemer new
]
