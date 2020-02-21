printing
printYMDHMS: aDate
	^ String
		streamContents: [ :s | 
			aDate printYMDOn: s.
			s space.
			aDate printHMSOn: s ]