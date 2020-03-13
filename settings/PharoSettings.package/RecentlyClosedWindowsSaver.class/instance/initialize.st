initialization
initialize
	super initialize.
	cache := LRUCache new.
	self numberOfWindowsToKeep: 10.
	self currentWorld announcer when: WindowClosed do: [ :ann | cache at: DateAndTime now put: ann window ]