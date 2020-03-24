rightSuper
ensureRightSuperIsCallInPackages: aCollectionOfPackages
	| methods |
	methods := (aCollectionOfPackages flatCollect: #methods) reject: #isFromTrait.
	self
		ensureSuperSetUpForMethods: methods;
		ensureSuperTearDownForMethods: methods;
		ensureSuperInitializeForMethods: methods