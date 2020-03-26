protocols
cleanProtocols
	| methods protocolsMap |
	methods := self localMethods.

	self cleanCloseProtocols.

	self ensureTestMethodsAreInRightProtocol.

	protocolsMap := self methodsInSpecificProtocolMap.
	methods do: [ :method | protocolsMap at: method selector ifPresent: [ :protocol | method protocol = protocol ifFalse: [ method protocol: protocol ] ] ].

	protocolsMap := self testMethodsInSpecificProtocolMap.
	methods
		select: [ :method | method class isTestCase ]
		thenDo: [ :method | protocolsMap at: method selector ifPresent: [ :protocol | method protocol = protocol ifFalse: [ method protocol: protocol ] ] ]