*PharoSettings
altConvertAllReferencesToUsing: arguments
	(self model allReferencesTo: (arguments at: 1))
		reject: [ :rbMethod |
			"We reject methods from trait to not recompile them in the class and duplicate the code."
			rbMethod method
				ifNil: [ false ]
				ifNotNil: #isFromTrait ]
		thenDo: [ :method | self convertMethod: method selector for: method modelClass using: (arguments at: 2) ]