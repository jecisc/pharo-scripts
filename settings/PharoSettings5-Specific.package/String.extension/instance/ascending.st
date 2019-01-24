*PharoSettings5-Specific
ascending
	^ [ :a :b | (a perform: self asSymbol) < (b perform: self asSymbol) ]