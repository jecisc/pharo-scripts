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
		order: 5;
		iconName: #configNew;
		with: [ self buildSubmenu: #Loading on: aBuilder ].

	(aBuilder item: #Seaside)
		parent: #Scripts;
		order: 10;
		iconName: #configNew;
		with: [ self buildSubmenu: #Seaside on: aBuilder ].

	(aBuilder item: #Synectique)
		parent: #Scripts;
		order: 15;
		iconName: #configNew;
		with: [ self buildSubmenu: #Synectique on: aBuilder ].

	(aBuilder item: #Browse)
		parent: #Scripts;
		order: 20;
		iconName: #configNew;
		with: [ self buildSubmenu: #Browse on: aBuilder ].

	(aBuilder item: #'Add to Iceberg')
		parent: #Scripts;
		order: 25;
		iconName: #configNew;
		with: [ self buildAddToIcebergOn: aBuilder ].

	(aBuilder item: #'Open natively Iceberg repository')
		parent: #Scripts;
		order: 30;
		iconName: #configNew;
		with: [ self buildOpenNativelyOn: aBuilder ]