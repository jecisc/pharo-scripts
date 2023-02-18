activation
traitsCommentTabActivation

	<classAnnotation>
	^ (SystemVersion current major < 11
		   ifTrue: [ ClyTabActivationStrategy ]
		   ifFalse: [ ClyTabActivationStrategyAnnotation ]) for: ClyClassComment asCalypsoItemContext