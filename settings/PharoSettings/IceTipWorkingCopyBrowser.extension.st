Extension { #name : 'IceTipWorkingCopyBrowser' }

{ #category : '*PharoSettings' }
IceTipWorkingCopyBrowser class >> myMetacelloCommandsWith: presenter forRootGroup: aCommandGroup [

	<extensionCommands>
	| newGroup |
	newGroup := CmCommandGroup forSpec
		            name: 'Cyril Metacello options';
		            description: 'Metacello install operations';
		            yourself.

	{
		IceTipMetacelloInstallBaselineGroupUsingIncomingCommand.
		IceTipMetacelloInstallBaselineGroupUsingLoadedCommand.
		IceTipMetacelloInstallDefaultUsingIncommingCommand.
		IceTipMetacelloInstallDefaultUsingLoadedCommand } do: [ :each |
		newGroup register: (SystemVersion current major < 12
				 ifTrue: [ each forSpec ]
				 ifFalse: [ each forSpecContext: presenter ]) ].

	aCommandGroup / self selectionCommandGroupName register: newGroup
]
