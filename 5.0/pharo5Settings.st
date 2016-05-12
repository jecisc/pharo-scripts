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
		code: [ShortcutReminder defaultReminder position: #topRight ]
		runOnce: true.
	
}