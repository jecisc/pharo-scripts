initialization
fixRenameRefactoringBug
	<script>
	(RBRefactoring >> #convertAllReferencesTo:using:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altConvertAllReferencesToUsing:;
				arguments: #(#arguments);
				control: #instead)