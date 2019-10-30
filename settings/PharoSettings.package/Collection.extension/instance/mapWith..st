*PharoSettings
mapWith: aValuable
	^ (self collect: [ :e | e -> (aValuable value: e) ]) asDictionary