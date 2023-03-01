Class {
	#name : #DarkBlueThemeConfigurator,
	#superclass : #DarkThemeColorConfigurator,
	#category : 'PharoSettings11'
}

{ #category : #'accessing colors' }
DarkBlueThemeConfigurator >> backgroundColor [
	^ Color r: 0.116 g: 0.147 b: 0.210
]

{ #category : #'accessing colors' }
DarkBlueThemeConfigurator >> balloonBackgroundColor [

	^ self backgroundColor lighter
]

{ #category : #accessing }
DarkBlueThemeConfigurator >> baseColor [
	^ Color r: 16r26 g: 16r2f b: 16r49 range: 16rFF
]

{ #category : #accessing }
DarkBlueThemeConfigurator >> basePassiveBackgroundColor [
	^ self baseColor lighter
]

{ #category : #accessing }
DarkBlueThemeConfigurator >> baseSelectionColor [
	^ (Color r: 0.243 g: 0.271 b: 0.394 alpha: 1.0)
]

{ #category : #'accessing colors' }
DarkBlueThemeConfigurator >> borderColor [
	^ self darkBaseColor adjustBrightness: -0.04
]

{ #category : #'accessing colors' }
DarkBlueThemeConfigurator >> buttonColor [
	^ self backgroundColor
]

{ #category : #accessing }
DarkBlueThemeConfigurator >> darkBaseColor [
	^ self baseColor
]

{ #category : #'fill-styles' }
DarkBlueThemeConfigurator >> desktopColor [
	^ self backgroundColor muchDarker
]

{ #category : #'growl - specific' }
DarkBlueThemeConfigurator >> growlBorderColorFor: aGrowlMorph [
	^ self borderColor alpha: 0.5
]

{ #category : #'growl - specific' }
DarkBlueThemeConfigurator >> growlFillColorFor: aGrowlMorph [
	^ self lightBackgroundColor alpha: 0.5
]

{ #category : #'accessing colors' }
DarkBlueThemeConfigurator >> lightBackgroundColor [
	^ Color r: 16r30 g: 16r3b b: 16r4f range: 16rff
]

{ #category : #accessing }
DarkBlueThemeConfigurator >> lightBaseColor [
	^ self baseColor lighter
]

{ #category : #accessing }
DarkBlueThemeConfigurator >> lightSelectionColor [
	^ self baseSelectionColor lighter
]

{ #category : #'accessing colors' }
DarkBlueThemeConfigurator >> secondarySelectionColor [
	^ self selectionColor alpha: 0.4
]

{ #category : #'accessing colors' }
DarkBlueThemeConfigurator >> selectionColor [
	^ self baseSelectionColor lighter
]
