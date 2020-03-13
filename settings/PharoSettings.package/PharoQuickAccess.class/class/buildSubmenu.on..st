world menu
buildSubmenu: cat on: aBuilder
	(self methodsIn: cat asLowercase)
		do: [ :method | 
			(method pragmaAt: #name:)
				ifNotNil: [ :p | 
					(aBuilder item: (p argumentAt: 1))
						parent: cat;
						action: [ self execute: method selector ];
						iconName: #smallDoIt ] ]