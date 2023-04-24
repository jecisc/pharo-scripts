"
Command to load baseline group using loaded.
"
Class {
	#name : #IceTipMetacelloInstallBaselineGroupUsingLoadedCommand,
	#superclass : #IceTipMetacelloInstallBaselineGroupCommand,
	#category : #PharoSettings9
}

{ #category : #accessing }
IceTipMetacelloInstallBaselineGroupUsingLoadedCommand class >> defaultName [
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
