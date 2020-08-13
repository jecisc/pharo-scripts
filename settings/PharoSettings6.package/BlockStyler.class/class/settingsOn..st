settings
settingsOn: aBuilder
	<systemsettings>
	(aBuilder setting: #'BlockStyler')
		parent: #'Syntax Highlighting';
		target: self;
		selector: #enabled;
		with: [ (aBuilder setting: #defaultBackgroundColor) label: 'Background color' ]