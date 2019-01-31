*PharoSettings
toKill
	self flag: #toKill.
	('Method to kill ' , thisContext sender method printString , ' called by ' , thisContext sender sender method printString) logCr