Class {
	#name : #IceTipMetacelloInstallBaselineGroupUsingLoadedCommand,
	#superclass : #IceTipMetacelloInstallBaselineGroupCommand,
	#category : 'PharoSettings7To8'
}

{ #category : #accessing }
IceTipMetacelloInstallBaselineGroupUsingLoadedCommand class >> defaultMenuItemName [
	^ 'Install baseline using loaded...'
]

{ #category : #private }
IceTipMetacelloInstallBaselineGroupUsingLoadedCommand >> chooseConflictPolicyProject: projectName optionA: optionA optionB: optionB [
	^ #useLoaded
]

{ #category : #private }
IceTipMetacelloInstallBaselineGroupUsingLoadedCommand >> chooseUpgradePolicyProject: projectName optionA: optionA optionB: optionB [
	^ #useLoaded
]
