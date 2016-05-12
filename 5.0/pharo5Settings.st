StartupPreferencesLoader default executeAtomicItems: {			
	StartupAction
		name: 'Allow method creation completion'
		code: [	NECPreferences overrideModel: true ]
		runOnce: true.
		
	StartupAction
		name: 'Shortcut Reminder Notification limit'
		code: [ ShortcutReminder defaultReminder limit: -1 ]
		runOnce: true.	
		
	StartupAction
		name: 'Shortcut Reminder Position in World'
		code: [ ShortcutReminder defaultReminder position: #topRight ]
		runOnce: true.
		
	StartupAction
		name: 'Send diagnostics and usage data'
		code: [ Privacy sendDiagnosticsAndUsageData: true ]
		runOnce: true.
		
	StartupAction
		name: 'Color the stack'
		code: [ Smalltalk tools debugger enableStackColoring: true ]
		runOnce: true.
		
	StartupAction
		name: 'Directly open the full Debugger'
		code: [ Smalltalk tools debugger alwaysOpenFullDebugger: true ]
		runOnce: true.		
		
}