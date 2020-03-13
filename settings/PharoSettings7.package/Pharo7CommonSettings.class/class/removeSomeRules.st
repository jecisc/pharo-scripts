removing
removeSomeRules
	<script>
	(ReRuleManager class >> #excludedRuleNames) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altExcludedRuleNames;
				control: #instead).
	RBShouldntRaiseErrorRule enabled: false.
	ReRuleManager reset