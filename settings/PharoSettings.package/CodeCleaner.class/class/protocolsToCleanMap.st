protocols
protocolsToCleanMap
	| protocolsMap |
	protocolsMap := Dictionary new.
	protocolsMap
		at: #(#'instance-creation') put: #'instance creation';
		at: #(#remove #removal) put: #removing;
		at: #(#'initialize-release') put: #initialization;
		at: #(#utils #utility) put: #utilities;
		at: #(#'filein/out' #'fileIn/Out' #'fileIn/out' #'filein/Out') put: #'file in/out'.
	^ protocolsMap