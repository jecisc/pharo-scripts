initialization
addMetaLinkForClassDescription
	<script>
	| traitClass |
	traitClass := Smalltalk
		at:
			(SystemVersion current major >= 7
				ifTrue: [ #TClassDescription ]
				ifFalse: [ #TraitDescription ]).
	{ClassDescription.
	traitClass}
		do: [ :class | 
			(class >> #classCommentBlank) ast
				link:
					(MetaLink new
						metaObject: #receiver;
						selector: #alternativeBlankComment;
						control: #instead) ]