codax
cppDupDetInPlayground
	<name: #'CPP script duplication detection in playground'>
	GTPlayground openContents: 'model := CPPModel allInstances last.

model clearDuplicationSystem.
MessageTally spyOn: [model dupSys: (DPDetector createDupSysFromParameters:(DPParameters new
				selectedPrograms: model entitiesForDupDetection;
				frequency: 2;
				minNumberOfLines: 100;
				minNumberOfCharacters: 80;
				cleaner: DPCPPCleaner new)).]'