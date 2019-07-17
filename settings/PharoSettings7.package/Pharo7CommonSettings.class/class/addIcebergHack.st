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
				
	(IceTipCheckoutBranchCommand class>> #canBeExecutedInContext:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altCanBeExecutedInContext:;
				arguments: #(#arguments);
				control: #instead)