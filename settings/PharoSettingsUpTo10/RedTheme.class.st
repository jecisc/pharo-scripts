Class {
	#name : #RedTheme,
	#superclass : #ColoredBasedTheme,
	#category : #PharoSettingsUpTo10
}

{ #category : #accessing }
RedTheme class >> baseColor [
	^ Color fromHexString: '520002'
]

{ #category : #query }
RedTheme class >> beCurrent [
	<script>
	super beCurrent
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

{ #category : #'accessing colors' }
RedTheme >> selectionColor [
	^ Color fromHexString: '73264d'
]

{ #category : #'accessing colors' }
RedTheme >> selectionTextColor [
	^ Color fromHexString: '993366'
]
