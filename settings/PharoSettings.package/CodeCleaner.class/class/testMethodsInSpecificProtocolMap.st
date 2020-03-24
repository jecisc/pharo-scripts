protocols
testMethodsInSpecificProtocolMap
	| protocolsMap |
	protocolsMap := Dictionary new.
	protocolsMap
		at: #setUp put: #running;
		at: #tearDown put: #running.
	^ protocolsMap