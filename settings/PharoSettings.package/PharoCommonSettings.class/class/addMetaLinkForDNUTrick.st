initialization
addMetaLinkForDNUTrick
	<script>
	(Object >> #doesNotUnderstand:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #generatesPotentialSetterOrGetterWith:context:;
				arguments: #(#arguments #context);
				control: #before)