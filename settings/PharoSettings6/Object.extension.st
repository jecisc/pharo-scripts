Extension { #name : #Object }

{ #category : #'*PharoSettings6' }
Object >> asFR [
	self deprecated: 'Util' transformWith: '`@receiver asFR' -> '`@receiver asFileReference'.
	^ self asFileReference
]

{ #category : #'*PharoSettings6' }
Object >> sc: aBlock [
	self deprecated: 'Util' transformWith: '`@receiver sc: `@argument' -> 'String streamContents: `@argument'.
	^ String streamContents: aBlock
]
