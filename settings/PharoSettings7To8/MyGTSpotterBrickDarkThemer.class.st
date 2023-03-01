Class {
	#name : #MyGTSpotterBrickDarkThemer,
	#superclass : #GTSpotterBrickDarkThemer,
	#category : 'PharoSettings7To8'
}

{ #category : #'brick-rubric' }
MyGTSpotterBrickDarkThemer >> rubricBackgroundColor [
	^ self spotterThemer backgroundColor
]

{ #category : #'brick-rubric' }
MyGTSpotterBrickDarkThemer >> scrollbarColor [
	^ Smalltalk ui theme scrollbarColor alpha: 0.5
]

{ #category : #'brick-rubric' }
MyGTSpotterBrickDarkThemer >> scrollpaneBackgroundColor [
	^ self spotterThemer backgroundColor
]
