protocols
cleanProtocolsOfPackages: aCollectionOfPackages
	| methods |
	methods := (aCollectionOfPackages flatCollect: #methods) reject: #isFromTrait.
	self cleanCloseProtocolsOfMethods: methods.
	self ensureTestMethodsAreInRightProtocolForMethods: methods.
	self ensureMatching: [ :method | method selector = #initialize ] areIn: #initialization for: methods