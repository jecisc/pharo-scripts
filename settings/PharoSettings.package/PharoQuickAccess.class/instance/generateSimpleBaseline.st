conveniance
generateSimpleBaseline
	<name: #'Generate simple baseline'>
	(UIManager default request: 'Name of the project')
		ifNotNil: [ :name | 
			| baselineName class |
			baselineName := 'BaselineOf' , name capitalized.
			class := BaselineOf
				subclass: baselineName asSymbol
				slots: {}
				classVariables: {}
				package: baselineName.

			class comment: 'I am a baseline to define the structure and dependencies of the ' , name , ' project.'.

			class
				compile:
					('baseline: spec
	<baseline>
	spec
		for: #common
		do: [
			"Dependencies"
			self materialDesignLite: spec.

			"Packages"
			spec
				package: ''{1}'';
				package: ''{1}-Tests'' with: [ spec requires: #(''{1}'') ].

			"Groups"
			spec
				group: ''Core'' with: #(''{1}'');
				group: ''Tests'' with: #(''{1}-Tests'') ].' format: {name})
				classified: 'baseline'.

			class
				compile:
					'materialDesignLite: spec
	spec
		baseline: ''MaterialDesignLite'' with: [ spec repository: ''github://DuneSt/MaterialDesignLite:v2.x.x/src'' ]'
				classified: 'dependencies'.

			class
				compile:
					'projectClass
	^ MetacelloCypressBaselineProject'
				classified: 'accessing'.

			class browse ]