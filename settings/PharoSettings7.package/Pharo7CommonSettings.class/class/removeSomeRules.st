removing
removeSomeRules
	<script>
	self flag: #todo. "Add a way to disable those if they are loaded *after* startup. Maybe register to the class added announcement?"
	#(#GRNonPortableSourceFormatRule #GRTestAssertionsRule #GRUsesCurlyBraceArraysRule #GRAnsiStreamsRule #GRAnsiExceptionsRule #GREmptyStatementsRule #GRInvalidObjectInitializationRule #GRUsesLiteralByteArraysRule #GRAnsiStringsRule #GRAnsiConvertorRule #GRObjectInRule #GRNonPortableMessageRule #GRAnsiConditionalsRule #GRAnsiBooleansRule #GRBasicNewInitializeMissingRule #GRAnsiCollectionsRule #GRUsesClassForHashRule #GRUsesCanPerformOrUnderstandRule #GRUsesNotPortableClassRule #GRNotPortableCollectionsRule #GRUsesMethodAnnotationsRule #GRAnsiCharactersRule)
		do: [ :each | self environment at: each ifPresent: [ :class | class enabled: false ] ].

	#(#RBShouldntRaiseErrorRule #ReShouldntRaiseErrorRule) do: [ :each | self environment at: each ifPresent: [ :class | class enabled: false ] ].

	ReRuleManager reset