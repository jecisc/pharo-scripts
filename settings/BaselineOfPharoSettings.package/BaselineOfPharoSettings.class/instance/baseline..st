baselines
baseline: spec
	<baseline>
	spec for: #common do: [ spec package: 'PharoSettings' ].
	
	spec for: #'pharo5.x' do: [ spec package: 'PharoSettings5-Specific' with: [ spec requires: #('PharoSettings') ] ].

	"This one is globaly for Kommiter and Nautilus that were removed in Pharo 7."
	spec for: #(#'pharo5.x' #'pharo6.x') do: [ spec package: 'PharoSettingsUpTo61' with: [ spec requires: #('PharoSettings') ] ].
	
	spec for: #(#'pharo5.x' #'pharo6.x' #'pharo7.x') do: [ spec package: 'PharoSettings5' with: [ spec requires: #('PharoSettings') ] ].
	spec for: #(#'pharo6.x' #'pharo7.x') do: [ spec package: 'PharoSettings6' with: [ spec requires: #('PharoSettings') ] ].
	spec for: #(#'pharo7.x') do: [ spec package: 'PharoSettings7' with: [ spec requires: #('PharoSettings') ] ]