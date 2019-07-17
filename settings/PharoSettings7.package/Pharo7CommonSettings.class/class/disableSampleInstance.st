initialization
disableSampleInstance
	<script>
	(ClySampleInstanceScript >> #executeOn:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #executeOnAlt:;
				arguments: #(#arguments);
				control: #instead)