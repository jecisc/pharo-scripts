codax
cppDupDet
	<name: #'CPP script duplication detection'>
	| model |
	model := (self class environment at: #CPPModel) allInstances last.

	model clearDuplicationSystem.
	MessageTally
		spyOn: [ model
				dupSys:
					((self class environment at: #DPDetector)
						createDupSysFromParameters:
							((self class environment at: #DPParameters) new
								selectedPrograms: model entitiesForDupDetection;
								frequency: 2;
								minNumberOfLines: 100;
								minNumberOfCharacters: 80;
								cleaner: (self class environment at: #DPCPPCleaner) new)) ]