accessing
localMethods
	^ (packages flatCollect: #methods) reject: #isFromTrait