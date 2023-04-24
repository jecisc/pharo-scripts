"
Green theme configurator.
"
Class {
	#name : #GreenThemeConfigurator,
	#superclass : #ColoredBasedThemeConfigurator,
	#category : #PharoSettings11
}

{ #category : #accessing }
GreenThemeConfigurator >> baseColor [
	^ Color fromHexString: '1F774D'
]

{ #category : #accessing }
GreenThemeConfigurator >> selectionColor [
	^ Color fromHexString: '1F774D'
]
