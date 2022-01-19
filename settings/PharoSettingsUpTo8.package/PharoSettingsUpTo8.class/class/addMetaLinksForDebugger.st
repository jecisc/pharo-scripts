initialization
addMetaLinksForDebugger
	<script>
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