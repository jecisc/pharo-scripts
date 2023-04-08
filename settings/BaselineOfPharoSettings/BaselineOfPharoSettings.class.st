Class {
	#name : #BaselineOfPharoSettings,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoSettings
}

{ #category : #baselines }
BaselineOfPharoSettings >> baseline: spec [
	<baseline>
	spec for: #common do: [
		spec
			package: 'PharoSettings' with: [ spec requires: #('PharoSettings-Scripts') ];
			package: 'PharoSettings-Scripts' ].
	
	spec for: (self pharoVersionsFrom: 8) do: [ spec package: 'PharoSettings8' with: [ spec requires: #('PharoSettings') ] ].
	
	spec for: (self pharoVersionsFrom: 9) do: [ spec package: 'PharoSettings9' with: [ spec requires: #('PharoSettings') ] ].
	
	spec for: (self pharoVersionsFrom: 11) do: [ spec package: 'PharoSettings11' with: [ spec requires: #('PharoSettings') ] ].

	"This one is from the removal of BlueInk and GTEventRecorder."
	spec for: #(#'pharo7.x') do: [ spec package: 'PharoSettings7-Specific' with: [ spec requires: #('PharoSettings') ] ].
	
	"This one is for the cmd + (shift +) click on symbols."
	spec for: #(#'pharo7.x' #'pharo8.x') do: [ spec package: 'PharoSettingsUpTo8' with: [ spec requires: #('PharoSettings') ] ].
	
	"My theme without color palette"
	spec for: #(#'pharo7.x' #'pharo8.x') do: [ spec package: 'PharoSettings7To8' with: [ spec requires: #('PharoSettings' 'PharoSettingsUpTo10') ] ].
	
	"This on is for some Calypso options"
	spec for: #(#'pharo7.x' #'pharo8.x' #'pharo9.x' #'pharo10.x') do: [ spec package: 'PharoSettingsUpTo10' with: [ spec requires: #('PharoSettings') ] ].
	
	"This is to fix a bug in Pharo 9 that is fixed in Pharo 10"
	spec for: #'pharo9.x' do: [ spec package: 'PharoSettings9-Specific' with: [ spec requires: #('PharoSettings') ] ].
]

{ #category : #baselines }
BaselineOfPharoSettings >> pharoVersionsFrom: aVersion [
	^ (aVersion to: SystemVersion current major) collect: [ :v | ('pharo' , v asString , '.x') asSymbol ]
]
