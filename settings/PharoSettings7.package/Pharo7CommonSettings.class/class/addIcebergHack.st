initialization
addIcebergHack
	"Add a hack to fetch a project if a commit is not found."

	<script>
	(IceGitCommit >> #project) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #projectAlt;
				control: #instead).

	"In the «New branch from issue» panel of Iceberg, select origin as remote all the time and not mine or another remote.
	In P9 the method was renamed."
	(IceGitHubNewBranchFromIssuePanel
		>>
			(SystemVersion current major < 9
				ifTrue: [ #initializeWidgetsContents ]
				ifFalse: [ #initializePresenters ])) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #selectOrigin;
				control: #after)