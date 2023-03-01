Extension { #name : #IceTipCheckoutBranchCommand }

{ #category : #'*PharoSettings7To8' }
IceTipCheckoutBranchCommand class >> altCanBeExecutedInContext: args [
	^ args first isRepositoryMissing not
]
