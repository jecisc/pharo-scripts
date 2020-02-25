class initialization
addMetalinkToCmdClickOnSymbols
	<script>
	(SHRBTextStyler >> #visitLiteralValueNode:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altVisitLiteralValueNode:;
				arguments: #(#arguments);
				control: #instead)