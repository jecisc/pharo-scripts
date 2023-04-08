Class {
	#name : #IceTipMetacelloInstallDefaultUsingLoadedCommand,
	#superclass : #IceTipMetacelloInstallBaselineDefaultCommand,
	#category : #PharoSettingsUpTo8
}

{ #category : #accessing }
IceTipMetacelloInstallDefaultUsingLoadedCommand class >> defaultMenuItemName [
	^ 'Install baseline (default) using loaded'
]

{ #category : #private }
IceTipMetacelloInstallDefaultUsingLoadedCommand >> chooseConflictPolicyProject: projectName optionA: optionA optionB: optionB [
	^ #useLoaded
]

{ #category : #private }
IceTipMetacelloInstallDefaultUsingLoadedCommand >> chooseUpgradePolicyProject: projectName optionA: optionA optionB: optionB [
	^ #useLoaded
]
