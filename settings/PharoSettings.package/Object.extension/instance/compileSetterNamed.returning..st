*PharoSettings
compileSetterNamed: message returning: var
	self class
		compile:
			(String
				streamContents: [ :s |
					s
						<< message;
						<< ' anObject';
						<< String cr;
						<< Character tab;
						<< var;
						<< ' := anObject' ])
		classified: 'accessing'.
	UIManager default inform: 'Compiled: ' , message , ' into: ' , self printString