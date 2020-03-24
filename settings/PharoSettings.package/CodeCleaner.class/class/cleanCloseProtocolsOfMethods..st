protocols
cleanCloseProtocolsOfMethods: methods
	self protocolsToCleanMap keysAndValuesDo: [ :olds :new | methods do: [ :meth | (olds includes: meth protocol) ifTrue: [ meth protocol: new ] ] ]