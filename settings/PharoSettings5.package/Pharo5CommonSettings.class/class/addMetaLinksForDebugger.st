initialization
addMetaLinksForDebugger
	<script>
	{(RestartDebugAction -> 'Restart').
	(ResumeDebugAction -> 'Resume').
	(StepIntoDebugAction -> 'Into').
	(StepOverDebugAction -> 'Over').
	(StepThroughDebugAction -> 'Through')} asDictionary
		keysAndValuesDo: [ :class :label | 
			| node link |
			node := (class >> #defaultLabel) ast.
			link := MetaLink new
				metaObject: [ label asText addAttribute: TextEmphasis underlined from: 1 to: 1 ];
				control: #instead.
			node link: link ]