*PharoSettings
instanceCreationMenu: aBuilder
	<nautilusGlobalProtocolMenu>
	(aBuilder item: #'Add instance creation...')
		action: [ aBuilder model addInstanceCreation ];
		order: 90