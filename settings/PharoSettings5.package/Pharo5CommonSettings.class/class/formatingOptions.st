initialization
formatingOptions
	<script>
	[ BIConfigurableFormatter
		multiLineMessages: '#(#on:do: #ensure: #ifCurtailed:)';
		retainBlankLinesBetweenStatements: true;
		maxLineLength: 160.
	(BIConfigurableFormatter >> #formatArray:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #myFormatArray:;
				arguments: #(#arguments);
				control: #instead) ] on: Error do: [ "Temporary hack because BlueInk was removed from Pharo 8 without any announce..." ]