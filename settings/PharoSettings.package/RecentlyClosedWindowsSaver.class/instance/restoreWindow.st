actions
restoreWindow
	| labels values |
	labels := OrderedCollection new.
	values := OrderedCollection new.

	cache
		keysAndValuesDo: [ :date :window | 
			labels add: (self printYMDHMS: date) , ' ' , window label.
			values add: window ].

	(UIManager default chooseFrom: labels values: values) ifNotNil: [ :window | window openAsIs ]