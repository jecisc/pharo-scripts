*PharoSettings
haltOnceIf: aBlock
	"This is the typical message to use for inserting breakpoints during debugging."

	<debuggerCompleteToSender>
	(aBlock cull: self) ifTrue: [ self haltOnce ]