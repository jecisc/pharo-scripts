world menu
buildScriptsOf: aClass on: aBuilder
	(aBuilder item: ('From: ' , aClass name) asSymbol)
		iconName: #configNew;
		with: [ (Pragma allNamed: #script in: aClass class)
				do: [ :pragma | 
					(aBuilder item: (' ' join: pragma method selector capitalized mySplitCamelCase))
						action: [ aClass perform: pragma method selector ];
						iconName: #smallDoIt ] ].

	aClass subclassesDo: [ :subClass | self buildScriptsOf: subClass on: aBuilder ]