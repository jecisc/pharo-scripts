class initialization
addMetalinkToCmdClickOnSymbols
	<script>
	(SHRBTextStyler
		>>
			(SystemVersion current major > 6
				ifTrue: [ #visitLiteralValueNode: ]
				ifFalse: [ #visitLiteralNode: ])) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altVisitLiteralValueNode:;
				arguments: #(#arguments);
				control: #instead)