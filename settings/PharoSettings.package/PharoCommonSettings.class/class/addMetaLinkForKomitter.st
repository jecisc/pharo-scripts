initialization
addMetaLinkForKomitter
	<script>
	(KomitStagingArea >> #remotes) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #remotesAlt;
				control: #instead)