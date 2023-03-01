Class {
	#name : #IceTipMetacelloInstallBaselineGroupUsingIncomingCommand,
	#superclass : #IceTipMetacelloInstallBaselineGroupCommand,
	#category : 'PharoSettings7To8'
}

{ #category : #accessing }
IceTipMetacelloInstallBaselineGroupUsingIncomingCommand class >> defaultMenuItemName [
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
