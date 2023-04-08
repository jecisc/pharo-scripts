Class {
	#name : #IceTipMetacelloInstallDefaultUsingIncommingCommand,
	#superclass : #IceTipMetacelloInstallBaselineDefaultCommand,
	#category : #PharoSettingsUpTo8
}

{ #category : #accessing }
IceTipMetacelloInstallDefaultUsingIncommingCommand class >> defaultMenuItemName [
	^ 'Install baseline (default) using incoming'
]

{ #category : #private }
IceTipMetacelloInstallDefaultUsingIncommingCommand >> chooseConflictPolicyProject: projectName optionA: optionA optionB: optionB [
	^ #useIncoming
]

{ #category : #private }
IceTipMetacelloInstallDefaultUsingIncommingCommand >> chooseUpgradePolicyProject: projectName optionA: optionA optionB: optionB [
	^ #useIncoming
]
