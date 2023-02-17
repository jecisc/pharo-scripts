accessing
executeBlock: aBlock
	[ aBlock value.
	self inform: 'Executed with success' ]
		on: Error
		do: [ :ex |
			self
				inform:
					'Error during execution.
' , ex asString ]