initialization
addMetaLinkForClassDescription
	<script>
	{ClassDescription. TraitDescription } do: [ :class | 
	(class >> #classCommentBlank) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #alternativeBlankComment;
				control: #instead). ]