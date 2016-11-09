baselines
baseline: spec
	<baseline>
	spec for: #common do: [ spec package: 'PharoSettings' ].
	spec for: #'pharo5.x' do: [ spec package: 'PharoSettings5-Specific' ].
	spec for: #(#'pharo5.x' #'pharo6.x') do: [ spec package: 'PharoSettings5' ]