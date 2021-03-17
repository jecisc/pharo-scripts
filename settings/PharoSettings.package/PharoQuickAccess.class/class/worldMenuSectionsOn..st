world menu
worldMenuSectionsOn: aBuilder
	<worldMenu>
	(aBuilder item: #Scripts)
		order: 6.0;
		iconName: #changeUpdate;
		with: [ (aBuilder item: #Conveniance)
				order: 1;
				iconName: #configNew;
				with: [ self buildSubmenu: #Conveniance on: aBuilder. ].

			(aBuilder item: #Templates)
				order: 3;
				iconName: #configNew;
				with: [ self buildSubmenu: #Templates on: aBuilder ].

			(aBuilder item: #Loading)
				order: 5;
				iconName: #configNew;
				with: [ self buildSubmenu: #Loading on: aBuilder ].

			(aBuilder item: #'Seaside scripts')
				order: 10;
				iconName: #configNew;
				with: [ self buildSubmenu: 'Seaside scripts' on: aBuilder ].

			(aBuilder item: #'Browse-settings')
				order: 20;
				iconName: #configNew;
				with: [ self buildSubmenu: #'Browse-settings' on: aBuilder ].

			(aBuilder item: #RecentWindows)
				order: 23;
				iconName: #configNew;
				with: [ self buildSubmenu: #RecentWindows on: aBuilder ].

			(aBuilder item: #'Add to Iceberg')
				order: 25;
				iconName: #configNew;
				with: [ self buildAddToIcebergOn: aBuilder ].

			(aBuilder item: #'Open natively Iceberg repository')
				order: 30;
				iconName: #configNew;
				with: [ self buildOpenNativelyOn: aBuilder ] ]