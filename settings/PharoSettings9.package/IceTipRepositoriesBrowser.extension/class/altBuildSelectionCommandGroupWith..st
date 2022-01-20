*PharoSettings9
altBuildSelectionCommandGroupWith: args
	{
		IceTipRepairCommand.
		IceTipManagePackagesCommand.
		IceTipBrowsePackagesInGroupCommand.
		IceTipCommitCommand.
		IceTipPullCommand.
		IceTipPushCommand.
		IceTipFetchCommand.
		IceTipCheckoutBranchCommand.
	 	IceTipCreateTagCommand.
		IceTipMergeCommand.
		IceTipManageRepositoryCommand.
		IceTipEditRepositoryCommand.
		IceTipForgetRepositoryCommand
		} do: [ :each |
			(args at: 2) register: each forSpec ]