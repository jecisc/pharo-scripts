*PharoSettings
compileGetterNamed: var
	self class
		compile:
			(String
				streamContents: [ :s |
					s
						<< var;
						cr;
						<< Character tab;
						<< '^ ';
						<< var ])
		classified: 'accessing'.
	UIManager default inform: 'Compiled: ' , var , ' into: ' , self printString