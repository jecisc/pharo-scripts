*PharoSettings6
sc: aBlock
	self deprecated: 'Util' transformWith: '`@receiver sc: `@argument' -> 'String streamContents: `@argument'.
	^ String streamContents: aBlock