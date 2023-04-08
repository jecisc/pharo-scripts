Class {
	#name : #ColoredBasedTheme,
	#superclass : #PharoDarkTheme,
	#category : #PharoSettingsUpTo10
}

{ #category : #accessing }
ColoredBasedTheme class >> baseColor [
	^ self subclassResponsibility
]

{ #category : #accessing }
ColoredBasedTheme class >> basePassiveBackgroundColor [
	^ self baseColor lighter
]

{ #category : #query }
ColoredBasedTheme class >> beCurrent [
	super beCurrent.
	PharoCommonSettings setThemeSetting
]

{ #category : #accessing }
ColoredBasedTheme class >> darkBaseColor [
	^ self baseColor darker
]

{ #category : #accessing }
ColoredBasedTheme class >> isAbstract [
	^ self = ColoredBasedTheme
]

{ #category : #accessing }
ColoredBasedTheme class >> lightBaseColor [
	^ self baseColor lighter
]

{ #category : #'accessing colors' }
ColoredBasedTheme >> backgroundColor [
	^ self baseColor muchDarker
]

{ #category : #'accessing colors' }
ColoredBasedTheme >> borderColor [
	^ self class darkBaseColor adjustBrightness: -0.04
]

{ #category : #'border-styles' }
ColoredBasedTheme >> buttonBorderStyleFor: aButton [
	aButton borderStyle: (BorderStyle width: 1 color: self borderColor)
]

{ #category : #'accessing colors' }
ColoredBasedTheme >> buttonColor [
	^ self baseColor darker
]

{ #category : #'accessing colors' }
ColoredBasedTheme >> lightBackgroundColor [
	^ self backgroundColor lighter
]

{ #category : #'fill-styles' }
ColoredBasedTheme >> progressBarProgressFillStyleFor: aProgressBar [
	^ self subclassResponsibility
]

{ #category : #'accessing colors' }
ColoredBasedTheme >> secondarySelectionColor [
	^ self selectionTextColor alpha: 0.4
]

{ #category : #'accessing colors' }
ColoredBasedTheme >> selectionColor [
	^ self subclassResponsibility
]

{ #category : #'accessing colors' }
ColoredBasedTheme >> selectionTextColor [
	^ self selectionColor darker
]

{ #category : #'fill-styles-taskbar' }
ColoredBasedTheme >> taskbarFillStyleFor: aTaskbar [
	^ SolidFillStyle color: (self backgroundColor muchDarker alpha: 0.8)
]

{ #category : #'accessing colors' }
ColoredBasedTheme >> windowColor [
	^ self baseColor
]
