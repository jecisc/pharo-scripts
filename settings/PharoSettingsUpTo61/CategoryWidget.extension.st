Extension { #name : #CategoryWidget }

{ #category : #'*PharoSettingsUpTo61' }
CategoryWidget classSide >> instanceCreationMenu: aBuilder [
	<nautilusGlobalProtocolMenu>
	(aBuilder item: #'Add instance creation...')
		action: [ aBuilder model addInstanceCreation ];
		order: 90
]
