"
Pink theme configurator
"
Class {
	#name : #PinkThemeConfigurator,
	#superclass : #ColoredBasedThemeConfigurator,
	#category : #PharoSettings11
}

{ #category : #accessing }
PinkThemeConfigurator >> baseColor [
	^ Color fromHexString: 'c2185b'
]

{ #category : #'accessing colors' }
PinkThemeConfigurator >> selectionColor [
	^ Color fromHexString: '73264d'
]

{ #category : #'accessing colors' }
PinkThemeConfigurator >> selectionTextColor [
	^ Color fromHexString: '993366'
]
