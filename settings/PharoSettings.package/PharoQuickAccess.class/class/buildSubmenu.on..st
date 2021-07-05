world menu
buildSubmenu: cat on: aBuilder
	"Sometimes I add insecable spaces to separate different menus with the same name."

	(self methodsIn: (cat asLowercase copyWithout: $ ))
		do: [ :method | 
			(method pragmaAt: #name:)
				ifNotNil: [ :p | 
					(aBuilder item: (p argumentAt: 1))
						parent: cat;
						action: [ self execute: method selector ];
						iconName: #smallDoIt ] ]