initialization
fixRenameRefactoringBug
	<script>
	(RBRefactoring >> #convertAllReferencesTo:using:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altConvertAllReferencesToUsing:;
				arguments: #(#arguments);
				control: #instead).


	(RBRenameClassRefactoring >> #renameReferences) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altRenameReferences;
				control: #instead)