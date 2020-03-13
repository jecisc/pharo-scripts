accessing
default
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]