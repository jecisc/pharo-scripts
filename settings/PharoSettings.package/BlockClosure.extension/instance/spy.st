*PharoSettings
spy
	| res |
	TimeProfiler spyOn: [ res := self value ].
	^ res