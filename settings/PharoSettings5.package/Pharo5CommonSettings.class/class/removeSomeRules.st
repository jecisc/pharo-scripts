initialization
removeSomeRules
	<script>
	(ReRuleManager class >> #excludedRuleNames) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altExcludedRuleNames;
				control: #instead).

	ReRuleManager reset