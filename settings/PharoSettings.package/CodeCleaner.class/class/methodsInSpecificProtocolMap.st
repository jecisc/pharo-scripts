protocols
methodsInSpecificProtocolMap
	| protocolsMap |
	protocolsMap := Dictionary new.
	protocolsMap
		at: #initialize put: #initialization;
		at: #clone put: #copying;
		at: #copy put: #copying;
		at: #deepCopy put: #copying;
		at: #postCopy put: #copying;
		at: #veryDeepCopy put: #copying;
		at: #shallowCopy put: #copying;
		at: #= put: #comparing;
		at: #hash put: #comparing;
		at: #finalize put: #finalization;
		at: #finalizeValues put: #finalization;
		at: #isAbstract put: #testing.
	^ protocolsMap