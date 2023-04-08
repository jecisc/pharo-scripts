Class {
	#name : #DarkBlueTheme,
	#superclass : #PharoDarkTheme,
	#category : #PharoSettingsUpTo10
}

{ #category : #accessing }
DarkBlueTheme class >> baseColor [
	^ Color r: 16r26 g: 16r2f b: 16r49 range: 16rFF
]

{ #category : #accessing }
DarkBlueTheme class >> basePassiveBackgroundColor [
	^ self baseColor lighter
]

{ #category : #accessing }
DarkBlueTheme class >> baseSelectionColor [
	^ (Color r: 0.243 g: 0.271 b: 0.394 alpha: 1.0)
]

{ #category : #accessing }
DarkBlueTheme class >> baseTextColor [
	^ Color white
]

{ #category : #accessing }
DarkBlueTheme class >> darkBaseColor [
	^ self baseColor
]

{ #category : #accessing }
DarkBlueTheme class >> lightBaseColor [
	^ self baseColor lighter
]

{ #category : #accessing }
DarkBlueTheme class >> lightSelectionColor [
	^ self baseSelectionColor lighter
]

{ #category : #settings }
DarkBlueTheme class >> newDefaultSettings [
	self setPreferredPreferences.
	^ super newDefaultSettings
		menuColor: self baseColor;
		menuTitleColor: self baseColor;
		windowColor: self baseColor;
		selectionColor: self lightSelectionColor;
		menuSelectionColor: self baseSelectionColor;
		menuSelectionTextColor: self baseTextColor darker;
		progressBarColor: self baseColor;
		standardColorsOnly: true;
		autoSelectionColor: false;
		preferRoundCorner: false;
		fadedBackgroundWindows: false;
		"secondarySelectionColor: self veryLightSelectionColor;"
		flatMenu: true
]

{ #category : #accessing }
DarkBlueTheme class >> themeName [
	^ 'DarkBlue'
]

{ #category : #'accessing colors' }
DarkBlueTheme >> backgroundColor [
	^ Color r: 0.116 g: 0.147 b: 0.210
]

{ #category : #'accessing colors' }
DarkBlueTheme >> balloonBackgroundColor [

	^ self backgroundColor lighter
]

{ #category : #'accessing colors' }
DarkBlueTheme >> borderColor [
	^ self class darkBaseColor adjustBrightness: -0.04
]

{ #category : #'border-styles' }
DarkBlueTheme >> buttonBorderStyleFor: aButton [
	aButton borderStyle: (BorderStyle width: 1 color: self borderColor)
]

{ #category : #'accessing colors' }
DarkBlueTheme >> buttonColor [
	^ self backgroundColor
]

{ #category : #'border-styles-buttons' }
DarkBlueTheme >> buttonNormalBorderStyleFor: aButton [
	"Return the normal button borderStyle for the given button."

	(aButton valueOfProperty: #noBorder ifAbsent: [ false ])
		ifTrue: [
			^ SimpleBorder new
				width: 0;
				baseColor: Color transparent ].

	^ SimpleBorder new
		width: 1;
		baseColor: self buttonColor darker
]

{ #category : #'fill-styles' }
DarkBlueTheme >> desktopColor [
	^ self backgroundColor muchDarker
]

{ #category : #'growl - specific' }
DarkBlueTheme >> growlBorderColorFor: aGrowlMorph [
	^ self borderColor alpha: 0.5
]

{ #category : #'growl - specific' }
DarkBlueTheme >> growlFillColorFor: aGrowlMorph [
	^ self lightBackgroundColor alpha: 0.5
]

{ #category : #'accessing colors' }
DarkBlueTheme >> lightBackgroundColor [
	^ Color r: 16r30 g: 16r3b b: 16r4f range: 16rff
]

{ #category : #'accessing colors' }
DarkBlueTheme >> secondarySelectionColor [
	^ self selectionColor alpha: 0.4
]

{ #category : #'accessing colors' }
DarkBlueTheme >> selectionColor [
	^ self class baseSelectionColor lighter
]

{ #category : #'fill-styles' }
DarkBlueTheme >> windowInactiveFillStyleFor: aWindow [
	"We do not want the lighting effect when the window goes inactive"

	^ SolidFillStyle color: self class baseColor slightlyDarker slightlyDarker
]
