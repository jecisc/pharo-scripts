"
Command to load baseline default group using incommings
"
Class {
	#name : 'IceTipMetacelloInstallDefaultUsingIncommingCommand',
	#superclass : 'IceTipMetacelloInstallBaselineDefaultCommand',
	#category : 'PharoSettings9',
	#package : 'PharoSettings9'
}

{ #category : 'accessing' }
IceTipMetacelloInstallDefaultUsingIncommingCommand class >> defaultName [
	^ 'Install baseline (default) using incoming'
]

{ #category : 'private' }
IceTipMetacelloInstallDefaultUsingIncommingCommand >> chooseConflictPolicyProject: projectName optionA: optionA optionB: optionB [
	^ #useIncoming
]

{ #category : 'private' }
IceTipMetacelloInstallDefaultUsingIncommingCommand >> chooseUpgradePolicyProject: projectName optionA: optionA optionB: optionB [
	^ #useIncoming
]
