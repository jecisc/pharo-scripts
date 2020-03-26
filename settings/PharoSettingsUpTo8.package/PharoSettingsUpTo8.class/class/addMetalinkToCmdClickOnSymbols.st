class initialization
addMetalinkToCmdClickOnSymbols
	<script>
	self flag: #pharo7.
	(SHRBTextStyler >> ((SHRBTextStyler isLocalSelector: #visitLiteralNode:) ifTrue: [ #visitLiteralNode: ] ifFalse: [ #visitLiteralValueNode: ])) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altVisitLiteralValueNode:;
				arguments: #(#arguments);
				control: #instead)