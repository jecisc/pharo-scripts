baselines
baseline: spec
	<baseline>
	spec for: #common do: [
		spec
			package: 'PharoSettings' with: [ spec requires: #('PharoSettings-Scripts') ];
			package: 'PharoSettings-Scripts' ].
	
	spec for: (self pharoVersionsFrom: 6) do: [ spec package: 'PharoSettings6' with: [ spec requires: #('PharoSettings') ] ].
	
	spec for: (self pharoVersionsFrom: 7) do: [ spec package: 'PharoSettings7' with: [ spec requires: #('PharoSettings' 'PharoSettings6') "It's smoother in P6 settings are loaded before P7 settings." ] ].
	
	spec for: (self pharoVersionsFrom: 8) do: [ spec package: 'PharoSettings8' with: [ spec requires: #('PharoSettings') ] ].
	
	spec for: (self pharoVersionsFrom: 9) do: [ spec package: 'PharoSettings9' with: [ spec requires: #('PharoSettings') ] ].
	
	spec for: (self pharoVersionsFrom: 11) do: [ spec package: 'PharoSettings11' with: [ spec requires: #('PharoSettings') ] ].


	spec for: #'pharo5.x' do: [ spec package: 'PharoSettings5-Specific' with: [ spec requires: #('PharoSettings') ] ].

	"This one is globaly for Kommiter and Nautilus that were removed in Pharo 7."
	spec for: #(#'pharo5.x' #'pharo6.x') do: [ spec package: 'PharoSettingsUpTo61' with: [ spec requires: #('PharoSettings') ] ].

	"This one is from the removal of BlueInk and GTEventRecorder."
	spec for: #(#'pharo5.x' #'pharo6.x' #'pharo7.x') do: [ spec package: 'PharoSettingsUpTo7' with: [ spec requires: #('PharoSettings') ] ].
	
	"This one is for the cmd + (shift +) click on symbols."
	spec for: #(#'pharo5.x' #'pharo6.x' #'pharo7.x' #'pharo8.x') do: [ spec package: 'PharoSettingsUpTo8' with: [ spec requires: #('PharoSettings') ] ].
	
	"My theme without color palette"
	spec for: #(#'pharo7.x' #'pharo8.x') do: [ spec package: 'PharoSettings7To8' with: [ spec requires: #('PharoSettings' 'PharoSettings7' 'PharoSettings7To10') ] ].
	
	"This on is for some Calypso options"
	spec for: #(#'pharo7.x' #'pharo8.x' #'pharo9.x' #'pharo10.x') do: [ spec package: 'PharoSettings7To10' with: [ spec requires: #('PharoSettings') ] ].
	
	"This is to fix a bug in Pharo 9 that is fixed in Pharo 10"
	spec for: #'pharo9.x' do: [ spec package: 'PharoSettings9-Specific' with: [ spec requires: #('PharoSettings') ] ].