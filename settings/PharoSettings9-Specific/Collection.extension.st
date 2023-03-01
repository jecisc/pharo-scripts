Extension { #name : #Collection }

{ #category : #'*PharoSettings9-Specific' }
Collection >> collectionSizeThreshold [
	"To fix a bug in Pharo 9's spotter"

	^ 3000
]
