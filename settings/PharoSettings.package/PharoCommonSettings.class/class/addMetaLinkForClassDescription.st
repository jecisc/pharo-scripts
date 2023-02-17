initialization
addMetaLinkForClassDescription
	<script>
	(SystemVersion current major >= 7
		ifTrue: [ {ClassDescription} ]
		ifFalse: [ {ClassDescription.
			TraitDescription} ])
		do: [ :class |
			(class >> #classCommentBlank) ast
				link:
					(MetaLink new
						metaObject: #receiver;
						selector: #alternativeBlankComment;
						control: #instead) ]