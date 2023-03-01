Extension { #name : #Collection }

{ #category : #'*PharoSettings' }
Collection >> mapWith: aValuable [
	^ OrderedDictionary new
		in: [ :dic |
			self do: [ :e | dic at: e put: (aValuable value: e) ].
			dic ]
]
