Class {
	#name : #GreenTheme,
	#superclass : #ColoredBasedTheme,
	#category : #PharoSettingsUpTo10
}

{ #category : #accessing }
GreenTheme class >> baseColor [
	^ Color fromHexString: '1F774D'
]

{ #category : #query }
GreenTheme class >> beCurrent [
	<script>
	super beCurrent
]

{ #category : #accessing }
GreenTheme class >> themeName [
	^ 'Green Theme'
]

{ #category : #'basic-colors' }
GreenTheme >> progressBarProgressFillStyleFor: aProgressBar [
	^ Color fromHexString: '4CAF50'
]

{ #category : #'accessing colors' }
GreenTheme >> selectionColor [
	^ Color fromHexString: '1F774D'
]
