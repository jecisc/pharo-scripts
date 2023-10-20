Extension { #name : 'IceTipWorkingCopyBrowser' }

{ #category : '*PharoSettings9' }
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
		IceTipMetacelloInstallDefaultUsingLoadedCommand } do: [ :each | newGroup register: each forSpec ].

	aCommandGroup / self selectionCommandGroupName register: newGroup
]
