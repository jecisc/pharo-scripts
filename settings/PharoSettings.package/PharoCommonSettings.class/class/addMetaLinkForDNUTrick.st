initialization
addMetaLinkForDNUTrick
	<script>
	(Object >> #doesNotUnderstand:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altDNU:;
				arguments: #(#arguments);
				control: #instead)