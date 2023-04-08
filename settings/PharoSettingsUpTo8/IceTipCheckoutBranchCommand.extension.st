Extension { #name : #IceTipCheckoutBranchCommand }

{ #category : #'*PharoSettingsUpTo8' }
IceTipCheckoutBranchCommand class >> altCanBeExecutedInContext: args [
	^ args first isRepositoryMissing not
]
