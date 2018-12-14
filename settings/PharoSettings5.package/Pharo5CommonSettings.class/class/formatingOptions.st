initialization
formatingOptions
	<script>
	BIConfigurableFormatter
		multiLineMessages: '#(#on:do: #ensure: #ifCurtailed:)';
		retainBlankLinesBetweenStatements: true.
	(BIConfigurableFormatter >> #formatArray:) ast
				link:
					(MetaLink new
						metaObject: #receiver;
						selector: #myFormatArray:;
						arguments: #(#arguments);
						control: #instead)