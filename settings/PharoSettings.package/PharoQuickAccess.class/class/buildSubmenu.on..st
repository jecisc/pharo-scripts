world menu
buildSubmenu: cat on: aBuilder
	(self methodsIn: cat asLowercase)
		do: [ :method | 
			(aBuilder item: ((method pragmaAt: #name:) argumentAt: 1))
				parent: cat;
				action: [ self execute: method selector ];
				iconName: #smallDoIt ]