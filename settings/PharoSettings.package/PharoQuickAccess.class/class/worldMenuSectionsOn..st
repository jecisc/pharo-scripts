world menu
worldMenuSectionsOn: aBuilder
	<worldMenu>	
	(aBuilder item: #Conveniance)
		parent: #Scripts;
		order: 1;
		iconName: #configNew;
		with: [ self buildSubmenu: #Conveniance on: aBuilder ].
		
	(aBuilder item: #Templates)
		parent: #Scripts;
		order: 3;
		iconName: #configNew;
		with: [ self buildSubmenu: #Templates on: aBuilder ].

	(aBuilder item: #Loading)
		parent: #Scripts;
		order: 5;
		iconName: #configNew;
		with: [ self buildSubmenu: #Loading on: aBuilder ].

	(aBuilder item: #'Seaside scripts')
		parent: #Scripts;
		order: 10;
		iconName: #configNew;
		with: [ self buildSubmenu: 'Seaside scripts' on: aBuilder ].

	(aBuilder item: #Codax)
		parent: #Scripts;
		order: 15;
		iconName: #configNew;
		with: [ self buildSubmenu: #Codax on: aBuilder ].

	(aBuilder item: #Browse)
		parent: #Scripts;
		order: 20;
		iconName: #configNew;
		with: [ self buildSubmenu: #Browse on: aBuilder ].
		
	(aBuilder item: #RecentWindows)
		parent: #Scripts;
		order: 23;
		iconName: #configNew;
		with: [ self buildSubmenu: #RecentWindows on: aBuilder ].

	(aBuilder item: #'Select background')
		parent: #Conveniance;
		order: 1;
		iconName: #configNew;
		with: [ self buildSelectBackgroundOn: aBuilder ].

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