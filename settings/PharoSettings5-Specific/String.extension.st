Extension { #name : #String }

{ #category : #'*PharoSettings5-Specific' }
String >> ascending [
	^ [ :a :b | (a perform: self asSymbol) < (b perform: self asSymbol) ]
]

{ #category : #'*PharoSettings5-Specific' }
String >> descending [
	^ [ :a :b | (a perform: self asSymbol) > (b perform: self asSymbol) ]
]
