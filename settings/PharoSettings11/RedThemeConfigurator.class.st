Class {
	#name : #RedThemeConfigurator,
	#superclass : #ColoredBasedThemeConfigurator,
	#category : 'PharoSettings11'
}

{ #category : #accessing }
RedThemeConfigurator >> baseColor [
	^ Color fromHexString: 'c62828'
]

{ #category : #'accessing colors' }
RedThemeConfigurator >> selectionColor [
	^ Color fromHexString: '73264d'
]

{ #category : #'accessing colors' }
RedThemeConfigurator >> selectionTextColor [
	^ Color fromHexString: '993366'
]
