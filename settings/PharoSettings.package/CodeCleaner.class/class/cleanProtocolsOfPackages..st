protocols
cleanProtocolsOfPackages: aCollectionOfPackages
	| methods protocolsMap |
	methods := (aCollectionOfPackages flatCollect: #methods) reject: #isFromTrait.

	self cleanCloseProtocolsOfMethods: methods.

	self ensureTestMethodsAreInRightProtocolForMethods: methods.

	protocolsMap := self methodsInSpecificProtocolMap.
	methods do: [ :method | protocolsMap at: method selector ifPresent: [ :protocol | method protocol = protocol ifFalse: [ method protocol: protocol ] ] ].

	protocolsMap := self testMethodsInSpecificProtocolMap.
	methods
		select: [ :method | method class isTestCase ]
		thenDo: [ :method | protocolsMap at: method selector ifPresent: [ :protocol | method protocol = protocol ifFalse: [ method protocol: protocol ] ] ]