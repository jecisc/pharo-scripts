rightSuper
ensureRightSuperIsCall
	| methods |
	methods := self localMethods.
	self
		ensureSuperSetUpForMethods: methods;
		ensureSuperTearDownForMethods: methods;
		ensureSuperInitializeForMethods: methods