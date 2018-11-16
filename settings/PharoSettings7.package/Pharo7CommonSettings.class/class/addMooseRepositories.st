initialization
addMooseRepositories
	<script>
	(self imageNameBeginsWithAny: #('MyMoose-' 'MooseNG-')) ifFalse: [ ^ self ].
	
	self registerIfPresentProjectOf: 'moosetechnology' named: 'Moose'.
	self registerIfPresentProjectOf: 'jecisc' named: 'Hashtable'.
	self registerIfPresentProjectOf: 'jecisc' named: 'Fame'.
	self registerIfPresentProjectOf: 'jecisc' named: 'KGBTestResources'.
	self registerIfPresentProjectOf: 'jecisc' named: 'PackageBlueprintTestResources'.
	self registerIfPresentProjectOf: 'RMODINRIA' named: 'RoelTyper'.
	self registerIfPresentProjectOf: 'jecisc' named: 'Famix'