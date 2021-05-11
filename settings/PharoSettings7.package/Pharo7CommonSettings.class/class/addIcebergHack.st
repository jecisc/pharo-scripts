initialization
addIcebergHack
	<script>

	"Add a hack to fetch a project if a commit is not found."
	(IceGitCommit >> #project) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #projectAlt;
				control: #instead).

	"In the «New branch from issue» panel of Iceberg, select origin as remote all the time and not mine or another remote."
	(IceGitHubNewBranchFromIssuePanel >> #initializeWidgetsContents) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #selectOrigin;
				control: #after)