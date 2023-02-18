as yet unclassified
findVaribleUsageInSubclasses

	<script>
	self open: 'origin := SpPresenter.
variables := origin instVarNames.

variables
	inject: Dictionary new
	into: [ :dict :var |
		dict
			at: var put: ((origin slots detect: [ :e | e name = var ]) usingMethods collect: #methodClass as: Set);
			yourself ]'