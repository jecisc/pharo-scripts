StartupPreferencesLoader default executeAtomicItems: {
	StartupAction
		name: 'Change debugger labels & shortcuts'
		code: [
			GLMMorphicActionRenderer compile: (
				(GLMMorphicActionRenderer>>#render:) sourceCode
					copyReplaceAll: 'setBalloonText: (anAction title'
					with: 'setBalloonText: (anAction title asString'
			).
			RestartDebugAction compile: 'defaultKeyText
	^ ''R''' classified: '*_UnpackagedPackage'.
			RestartDebugAction compile: 'defaultLabel
	^ ''Restart'' asText addAttribute: TextEmphasis underlined from: 1 to: 1' classified: '*_UnpackagedPackage'.
			ResumeDebugAction compile: 'defaultKeyText
	^ ''P''' classified: '*_UnpackagedPackage'.
			ResumeDebugAction compile: 'defaultLabel
	^ ''Proceed'' asText addAttribute: TextEmphasis underlined from: 1 to: 1' classified: '*_UnpackagedPackage'.
			StepIntoDebugAction compile: 'defaultKeyText
	^ ''I''' classified: '*_UnpackagedPackage'.
			StepIntoDebugAction compile: 'defaultLabel
	^ ''Into'' asText addAttribute: TextEmphasis underlined from: 1 to: 1' classified: '*_UnpackagedPackage'.
			StepOverDebugAction compile: 'defaultLabel
	^ ''Over'' asText addAttribute: TextEmphasis underlined from: 1 to: 1' classified: '*_UnpackagedPackage'.
			StepThroughDebugAction compile: 'defaultLabel
	^ ''Through'' asText addAttribute: TextEmphasis underlined from: 1 to: 1' classified: '*_UnpackagedPackage'.
				
			GTGenericStackDebugger compile: 'codeActionsPragmas
	^ #(customDebuggingAction codeDebuggingAction)' classified: '*_UnpackagedPackage'.
			
			GTRunToSelectionDebugAction class compile: 'gtStackDebuggingActionFor: aDebugger
	<gtStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
		icon: #bottom asIcon' classified: '*_UnpackagedPackage'.
				
			GTRunToSelectionDebugAction compile: 'defaultOrder

	^ 100' classified: '*_UnpackagedPackage'.
			
	{RestartDebugAction. ResumeDebugAction. StepIntoDebugAction. StepOverDebugAction. StepThroughDebugAction. GTRunToSelectionDebugAction}
		do: [ :each | 
			each class
				compile:
					(String
						streamContents: [ :s | 
							s
								<< ((each class >> #gtStackDebuggingActionFor:) sourceCode copyUpThrough: $>);
								cr;
								<< '	<gtCustomDebuggingAction>';
								<< ((each class >> #gtStackDebuggingActionFor:) sourceCode copyAfter: $>) ])
				classified: '*_UnpackagedPackage' ]
		]
		runOnce: true.
}