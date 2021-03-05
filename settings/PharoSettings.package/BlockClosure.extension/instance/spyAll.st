*PharoSettings
spyAll
	| res |
	TimeProfiler spyAllOn: [ res := self value ].
	^ res