"
Description
--------------------

One line summary. For example, ""I represent a paragraph of text"".

Three sentences about my main responsibilities - what I do, what I know.

State my main collaborators and one line about how I interact with them.

Public API and Key Messages
--------------------

- #
- #
- #

Examples
--------------------



Internal Representation and Key Implementation Points.
--------------------

"
Class {
	#name : #PinkTheme,
	#superclass : #ColoredBasedTheme,
	#category : 'PharoSettings11'
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
