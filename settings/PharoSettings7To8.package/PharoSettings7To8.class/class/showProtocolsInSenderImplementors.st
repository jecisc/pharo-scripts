initialization
showProtocolsInSenderImplementors
	<script>
	(ClyQueryBrowser >> #initializeNavigationViews) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altInitializeNavigationViews;
				control: #instead)