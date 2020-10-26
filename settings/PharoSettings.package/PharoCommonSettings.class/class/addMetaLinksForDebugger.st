initialization
addMetaLinksForDebugger
	<script>
	{(RestartDebugAction -> 'Restart').
	(ResumeDebugAction -> 'Resume').
	(StepIntoDebugAction -> 'Into').
	(StepOverDebugAction -> 'Over').
	(StepThroughDebugAction -> 'Through')} asDictionary
		keysAndValuesDo: [ :class :label | 
			(class >> #defaultLabel) ast
				link:
					(MetaLink new
						metaObject: [ label asText addAttribute: TextEmphasis underlined from: 1 to: 1 ];
						control: #instead) ].
	(GTRunToSelectionDebugAction >> #defaultOrder) ast
		link:
			(MetaLink new
				metaObject: [ 100 ];
				control: #instead).
	(GTGenericStackDebugger >> #codeActionsPragmas) ast
		link:
			(MetaLink new
				metaObject: [ #(customDebuggingAction codeDebuggingAction) ];
				control: #instead)