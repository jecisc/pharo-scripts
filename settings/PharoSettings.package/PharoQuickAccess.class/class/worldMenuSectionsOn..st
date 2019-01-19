world menu
worldMenuSectionsOn: aBuilder
	<worldMenu>
	(aBuilder item: #Conveniance)
		parent: #Scripts;
		order: 1;
		iconName: #configNew;
		with: [ self buildSubmenu: #Conveniance on: aBuilder ].

	(aBuilder item: #Loading)
		parent: #Scripts;
		order: 1;
		iconName: #configNew;
		with: [ self buildSubmenu: #Loading on: aBuilder ].

	(aBuilder item: #Seaside)
		parent: #Scripts;
		order: 1;
		iconName: #configNew;
		with: [ self buildSubmenu: #Seaside on: aBuilder ].

	(aBuilder item: #Synectique)
		parent: #Scripts;
		order: 1;
		iconName: #configNew;
		with: [ self buildSubmenu: #Synectique on: aBuilder ]