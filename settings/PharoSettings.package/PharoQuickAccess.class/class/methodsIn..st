accessing
methodsIn: aProtocol
	^ (self methods select: [ :method | method protocol = aProtocol ]) sort: #selector ascending