removing
removeSomeRules
	<script>
	(ReRuleManager class >> #excludedRuleNames) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altExcludedRuleNames;
				control: #instead).
	#(#RBShouldntRaiseErrorRule #ReShouldntRaiseErrorRule) do: [ :each | self environment at: each ifPresent: [ :class | class enabled: false ] ].
	ReRuleManager reset