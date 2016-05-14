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
				^ ''R'''.
			RestartDebugAction compile: 'defaultLabel
				^ ''Restart'' asText addAttribute: TextEmphasis underlined from: 1 to: 1'.
			ResumeDebugAction compile: 'defaultKeyText
				^ ''P'''.
			ResumeDebugAction compile: 'defaultLabel
				^ ''Proceed'' asText addAttribute: TextEmphasis underlined from: 1 to: 1'.
			StepIntoDebugAction compile: 'defaultKeyText
				^ ''I'''.
			StepIntoDebugAction compile: 'defaultLabel
				^ ''Into'' asText addAttribute: TextEmphasis underlined from: 1 to: 1'.
			StepOverDebugAction compile: 'defaultLabel
				^ ''Over'' asText addAttribute: TextEmphasis underlined from: 1 to: 1'.
			StepThroughDebugAction compile: 'defaultLabel
				^ ''Through'' asText addAttribute: TextEmphasis underlined from: 1 to: 1'.
		]
		runOnce: true.
}