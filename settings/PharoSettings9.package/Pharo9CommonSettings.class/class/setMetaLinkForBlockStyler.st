class initialization
setMetaLinkForBlockStyler

	<script>
	(ClyMethodEditorToolMorph >> #textChanged:) ast link: (MetaLink new
			 metaObject: #receiver;
			 selector: #myTextChanged:;
			 arguments: #( #arguments );
			 control: #instead)