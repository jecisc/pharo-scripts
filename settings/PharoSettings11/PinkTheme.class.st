"
a Pink theme
"
Class {
	#name : #PinkTheme,
	#superclass : #ColoredBasedTheme,
	#category : #PharoSettings11
}

{ #category : #query }
PinkTheme class >> beCurrent [
	<script>
	super beCurrent
]

{ #category : #configuration }
PinkTheme class >> colorConfiguratorClass [

	^ PinkThemeConfigurator
]

{ #category : #accessing }
PinkTheme class >> themeName [
	^ 'Pink Theme'
]

{ #category : #'fill-styles' }
PinkTheme >> progressBarProgressFillStyleFor: aProgressBar [
	"Answer the colour for the given progress bar."

	^ Color pink
]
