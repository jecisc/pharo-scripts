accessing
editingText
	^ String
		streamContents: [ :s | 
			editingClass traitComposition allTraits
				do: [ :trait | 
					trait hasComment
						ifTrue: [ s
								nextPutAll: '=== ';
								nextPutAll: trait name;
								nextPutAll: '===';
								lf;
								lf;
								nextPutAll: trait comment;
								lf;
								lf ] ] ]