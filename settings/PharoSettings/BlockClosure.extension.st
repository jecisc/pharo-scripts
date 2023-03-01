Extension { #name : #BlockClosure }

{ #category : #'*PharoSettings' }
BlockClosure >> spy [
	| res |
	TimeProfiler spyOn: [ res := self value ].
	^ res
]

{ #category : #'*PharoSettings' }
BlockClosure >> spyAll [
	| res |
	TimeProfiler spyAllOn: [ res := self value ].
	^ res
]
