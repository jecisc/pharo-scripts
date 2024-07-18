"
An abstract class to define some themes based on a color.
"
Class {
	#name : 'ColoredBasedTheme',
	#superclass : 'PharoDarkTheme',
	#category : 'PharoSettings11',
	#package : 'PharoSettings11'
}

{ #category : 'query' }
ColoredBasedTheme class >> beCurrent [
	super beCurrent.
	PharoCommonSettings setThemeSetting
]

{ #category : 'configuration' }
ColoredBasedTheme class >> colorConfiguratorClass [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ColoredBasedTheme class >> isAbstract [
	^ self = ColoredBasedTheme
]

{ #category : 'fill-styles' }
ColoredBasedTheme >> progressBarProgressFillStyleFor: aProgressBar [
	^ self subclassResponsibility
]

{ #category : 'fill-styles-taskbar' }
ColoredBasedTheme >> taskbarFillStyleFor: aTaskbar [
	^ SolidFillStyle color: (self backgroundColor muchDarker alpha: 0.8)
]
