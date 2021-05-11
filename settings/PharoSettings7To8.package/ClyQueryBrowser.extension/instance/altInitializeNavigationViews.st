*PharoSettings7To8
altInitializeNavigationViews
	resultView := self newNavigationView.
	resultView enableFilter: ClyQueryBrowserFilter.
	resultView allowsDeselection: false.
	resultView mainColumn
		width: 300;
		displayItemPropertyBy: [ :item | self classNameOf: item ].
	(resultView addColumn: #name)
		width: 400;
		displayItemPropertyBy: [ :item | self mainNameOf: item ].
	(resultView addColumn: #package)
		width: 300;
		displayItemPropertyBy: [ :item | self packageNameOf: item ].
	(resultView addColumn: #protocol)
		width: 200;
		displayItemPropertyBy: [ :item | 
			'('
				,
					([ item actualObject protocol ]
						on: Error
						do: [ 'Comment' ]) , ')' ]