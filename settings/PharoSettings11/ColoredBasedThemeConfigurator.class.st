"
configurator of colored themes
"
Class {
	#name : #ColoredBasedThemeConfigurator,
	#superclass : #DarkThemeColorConfigurator,
	#category : #PharoSettings11
}

{ #category : #testing }
ColoredBasedThemeConfigurator class >> isAbstract [

	^ self = ColoredBasedThemeConfigurator
]

{ #category : #'accessing colors' }
ColoredBasedThemeConfigurator >> backgroundColor [
	^ self baseColor muchDarker
]

{ #category : #accessing }
ColoredBasedThemeConfigurator >> baseColor [
	^ self subclassResponsibility
]

{ #category : #accessing }
ColoredBasedThemeConfigurator >> basePassiveBackgroundColor [
	^ self baseColor lighter
]

{ #category : #'accessing colors' }
ColoredBasedThemeConfigurator >> borderColor [

	^ self darkBaseColor adjustBrightness: -0.04
]

{ #category : #'accessing colors' }
ColoredBasedThemeConfigurator >> buttonColor [
	^ self baseColor darker
]

{ #category : #colors }
ColoredBasedThemeConfigurator >> darkBaseColor [
	^ self baseColor darker
]

{ #category : #'accessing colors' }
ColoredBasedThemeConfigurator >> lightBackgroundColor [
	^ self backgroundColor lighter
]

{ #category : #colors }
ColoredBasedThemeConfigurator >> lightBaseColor [
	^ self baseColor lighter
]

{ #category : #'accessing colors' }
ColoredBasedThemeConfigurator >> secondarySelectionColor [
	^ self selectionTextColor alpha: 0.4
]

{ #category : #'accessing colors' }
ColoredBasedThemeConfigurator >> selectionColor [
	^ self subclassResponsibility
]

{ #category : #'accessing colors' }
ColoredBasedThemeConfigurator >> selectionTextColor [
	^ self selectionColor darker
]

{ #category : #'accessing colors' }
ColoredBasedThemeConfigurator >> windowColor [
	^ self baseColor
]
