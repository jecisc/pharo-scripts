initialization
prepareForPharoContribution
	<script>
	(self imageNameBeginsWith: 'ContribPharo') ifFalse: [ ^ self ].

	IceRepository registry
		detect: [ :repo | repo workingCopy packages anySatisfy: [ :p | p name = 'BaselineOfPharo' ] ]
		ifFound: [ :pharoRepository |
			| defaultBranch |
			pharoRepository fetch.
			defaultBranch := 'Pharo' , SystemVersion current major asString , '.0'.

			pharoRepository branch name = defaultBranch ifTrue: [ ^ self ].

			"This mean that we are not on the default branch. Ask what to do."
			(UIManager default questionWithoutCancel: ('Currently on branch {1}. Want to switch to {2}?' format: {pharoRepository branch name . defaultBranch}))
				ifTrue: [ pharoRepository checkoutBranch: defaultBranch ] ]