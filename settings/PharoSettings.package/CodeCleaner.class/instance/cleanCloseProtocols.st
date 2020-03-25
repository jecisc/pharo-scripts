protocols
cleanCloseProtocols
	| methods |
	methods := self localMethods.
	self protocolsToCleanMap keysAndValuesDo: [ :olds :new | methods do: [ :meth | (olds includes: meth protocol) ifTrue: [ meth protocol: new ] ] ]