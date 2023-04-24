"
Command to load baseline default group using loaded
"
Class {
	#name : #IceTipMetacelloInstallDefaultUsingLoadedCommand,
	#superclass : #IceTipMetacelloInstallBaselineDefaultCommand,
	#category : #PharoSettings9
}

{ #category : #accessing }
IceTipMetacelloInstallDefaultUsingLoadedCommand class >> defaultName [
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
