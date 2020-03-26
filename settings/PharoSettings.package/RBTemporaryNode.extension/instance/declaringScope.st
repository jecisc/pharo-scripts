*PharoSettings
declaringScope
	| ancestor |
	ancestor := self parent.
	[ ancestor isNil ] whileFalse: [ (ancestor temporaries anySatisfy: [ :each | each name = self name ]) ifTrue: [ ^ ancestor ] ].
	self error: 'Undeclared temporary'