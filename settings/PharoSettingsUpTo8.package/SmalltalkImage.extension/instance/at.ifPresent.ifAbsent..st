*PharoSettingsUpTo8
at: key ifPresent: aBlock ifAbsent: anotherBlock
	"Lookup the given key in the globals. If it is present, answer the value of evaluating the given block with the value associated with the key. Otherwise answer the value of the second block."

	^ globals at: key ifPresent: aBlock ifAbsent: anotherBlock