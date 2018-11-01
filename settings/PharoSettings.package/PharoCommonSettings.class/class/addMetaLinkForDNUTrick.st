initialization
addMetaLinkForDNUTrick
	<script>
	(Object >> #doesNotUnderstand:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #generatesPotentialSetterOrGetterWith:;
				arguments: #(#arguments);
				control: #before)