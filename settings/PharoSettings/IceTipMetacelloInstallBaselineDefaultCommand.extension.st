Extension { #name : 'IceTipMetacelloInstallBaselineDefaultCommand' }

{ #category : '*PharoSettings' }
IceTipMetacelloInstallBaselineDefaultCommand >> basicInstallBaseline: icePackage groups: anArray [

	| packageDir sourceDirectory |
	sourceDirectory := icePackage repository project sourceDirectory.
	sourceDirectory ifEmpty: [ sourceDirectory := '.'].

	packageDir := (icePackage repository location / sourceDirectory) fullName.

	Metacello new
		repository: 'gitlocal://', packageDir;
		baseline: icePackage metacelloBaselineName;
		onUpgrade: [ :e | | policy |
			policy := self chooseUpgradePolicyFor: e.
			policy ifNotNil: [ e perform: policy ] ];
		onConflict: [ :e | | policy |
			policy := self chooseConflictPolicyFor: e.
			policy ifNotNil: [ e perform: policy ] ];
		silently;
		load: anArray
]
