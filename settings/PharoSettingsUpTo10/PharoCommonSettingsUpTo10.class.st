Class {
	#name : #PharoCommonSettingsUpTo10,
	#superclass : #PharoAbstractSettings,
	#category : #PharoSettingsUpTo10
}

{ #category : #'class initialization' }
PharoCommonSettingsUpTo10 class >> fixRenameRefactoringBug [
	<script>
	self flag: #todo.	"This is fix in P11 and should be move to a UpToP11 package"
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
]

{ #category : #'class initialization' }
PharoCommonSettingsUpTo10 class >> initialize [

	self fixRenameRefactoringBug
]
