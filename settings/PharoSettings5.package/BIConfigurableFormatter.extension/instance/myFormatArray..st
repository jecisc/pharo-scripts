*PharoSettings5
myFormatArray: args
	| current anArrayNode |
	anArrayNode := args anyOne.
	anArrayNode statements
		do: [:each | 
			current := each.
			self visitNode: each]
		separatedBy: [(self isLineTooLong: current value asString)
				ifTrue: [codeStream nextPut: $..
					self newLine]
				ifFalse: [codeStream nextPutAll: ' . ']]