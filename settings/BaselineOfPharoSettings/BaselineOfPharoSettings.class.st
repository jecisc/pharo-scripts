Class {
	#name : 'BaselineOfPharoSettings',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPharoSettings',
	#package : 'BaselineOfPharoSettings'
}

{ #category : 'baselines' }
BaselineOfPharoSettings >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'PharoSettings' with: [ spec requires: #('PharoSettings-Scripts') ];
				package: 'PharoSettings-Scripts' ].

	spec for: (self pharoVersionsFrom: 11) do: [ spec package: 'PharoSettings11' with: [ spec requires: #('PharoSettings') ] ].

	spec for: (self pharoVersionsFrom: 12) do: [ spec package: 'PharoSettings12' with: [ spec requires: #('PharoSettings') ] ].

	spec for: (self pharoVersionsFrom: 13) do: [ spec package: 'PharoSettings13' with: [ spec requires: #('PharoSettings') ] ].

	spec for: (self pharoVersionsFrom: 14) do: [ spec package: 'PharoSettings14' with: [ spec requires: #('PharoSettings') ] ].

	"This is to fix a bug in Pharo 9 that is fixed in Pharo 10"
	spec for: #'pharo9.x' do: [ spec package: 'PharoSettings9-Specific' with: [ spec requires: #('PharoSettings') ] ].
	
	"This on is for some Calypso options"
	spec for: #(#'pharo9.x' #'pharo10.x') do: [ spec package: 'PharoSettingsUpTo10' with: [ spec requires: #('PharoSettings') ] ].

	"Fluid class definition"
	spec for: #(#'pharo9.x' #'pharo10.x' #'pharo11.x') do: [ spec package: 'PharoSettingsUpTo11' with: [ spec requires: #('PharoSettings') ] ].

	"Dark Blue Theme before I integrated it in Pharo."
	spec for: #(#'pharo11.x' #'pharo12.x') do: [ spec package: 'PharoSettings11And12' with: [ spec requires: #('PharoSettings') ] ].	
	
	"Author"
	spec for: #(#'pharo9.x' #'pharo10.x' #'pharo11.x' #'pharo12.x') do: [ spec package: 'PharoSettingsUpTo12' with: [ spec requires: #('PharoSettings') ] ]
]

{ #category : 'baselines' }
BaselineOfPharoSettings >> pharoVersionsFrom: aVersion [
	^ (aVersion to: SystemVersion current major) collect: [ :v | ('pharo' , v asString , '.x') asSymbol ]
]
