initialization
icebergHack
	"I want the Branch option of Iceberg to be here even in Detached Head or even if the source directory is missing."

	<script>
	(IceTipCheckoutBranchCommand class >> #canBeExecutedInContext:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altCanBeExecutedInContext:;
				arguments: #(#arguments);
				control: #instead)