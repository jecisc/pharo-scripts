initialization
formatingOptions
	<script>
	BIConfigurableFormatter
		multiLineMessages:
			'#(#on:do: #ensure: #ifCurtailed: #ifTrue:ifFalse: #ifFalse:ifTrue: #ifEmtpy:ifNotEmpty: #ifNotEmpty:ifEmpty: #ifExists:ifAbsent: #ifNil:ifNotNil: #ifNotNil:ifNil: #detect:ifFound: #detect:ifNone: #detect:ifFound:ifNone: #at:ifPresent:ifAbsent: #collect:thenDo: #collect:thenReject: #collect:thenSelect:  #reject:thenCollect: #reject:thenDo: #select:thenCollect: #select:thenDo:)';
		retainBlankLinesBetweenStatements: true;
		maxLineLength: 160.
	(BIConfigurableFormatter >> #formatArray:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #myFormatArray:;
				arguments: #(#arguments);
				control: #instead)