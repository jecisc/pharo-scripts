accessing
instance
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]