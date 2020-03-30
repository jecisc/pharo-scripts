initialization
formatingOptions
	<script>
	BIConfigurableFormatter
		multiLineMessages: '#(#on:do: #ensure: #ifCurtailed: #ifTrue:ifFalse: #ifFalse:ifTrue: #ifEmtpy:ifNotEmpty: #ifNotEmpty:ifEmpty: #ifExists:ifAbsent: #ifNil:ifNotNil: #ifNotNil:ifNil:)';
		retainBlankLinesBetweenStatements: true;
		maxLineLength: 160.
	(BIConfigurableFormatter >> #formatArray:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #myFormatArray:;
				arguments: #(#arguments);
				control: #instead)