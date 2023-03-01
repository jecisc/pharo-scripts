Class {
	#name : #MySpotterWidgetDarkThemer,
	#superclass : #GTSpotterWidgetThemer,
	#category : 'PharoSettings7To8'
}

{ #category : #values }
MySpotterWidgetDarkThemer >> backgroundColor [
	^ Smalltalk ui theme lightBackgroundColor slightlyLighter
]

{ #category : #values }
MySpotterWidgetDarkThemer >> borderColor [
	^ Smalltalk ui theme borderColor
]
