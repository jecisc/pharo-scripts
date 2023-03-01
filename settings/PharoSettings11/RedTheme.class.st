Class {
	#name : #RedTheme,
	#superclass : #ColoredBasedTheme,
	#category : 'PharoSettings11'
}

{ #category : #query }
RedTheme class >> beCurrent [
	<script>
	super beCurrent
]

{ #category : #configuration }
RedTheme class >> colorConfiguratorClass [

	^ RedThemeConfigurator
]

{ #category : #accessing }
RedTheme class >> themeName [
	^ 'Red Theme'
]

{ #category : #'basic-colors' }
RedTheme >> progressBarProgressFillStyleFor: aProgressBar [
	"Answer the colour for the given progress bar."

	^ Color red
]
