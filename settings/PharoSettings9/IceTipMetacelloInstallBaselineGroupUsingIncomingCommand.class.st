Class {
	#name : #IceTipMetacelloInstallBaselineGroupUsingIncomingCommand,
	#superclass : #IceTipMetacelloInstallBaselineGroupCommand,
	#category : 'PharoSettings9'
}

{ #category : #accessing }
IceTipMetacelloInstallBaselineGroupUsingIncomingCommand class >> defaultName [
	^ 'Install baseline using incoming...'
]

{ #category : #private }
IceTipMetacelloInstallBaselineGroupUsingIncomingCommand >> chooseConflictPolicyProject: projectName optionA: optionA optionB: optionB [
	^ #useIncoming
]

{ #category : #private }
IceTipMetacelloInstallBaselineGroupUsingIncomingCommand >> chooseUpgradePolicyProject: projectName optionA: optionA optionB: optionB [
	^ #useIncoming
]
