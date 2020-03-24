protocols
ensureMatching: aBlock areIn: aProtocol for: aCollectionOfMethods
	aCollectionOfMethods select: aBlock thenDo: [ :method | method protocol = aProtocol ifFalse: [ method protocol: aProtocol ] ]