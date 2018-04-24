*PharoSettingsUpTo61
addInstanceCreation
	| newName |
	self okToChange
		ifFalse: [ ^ self ].
	self selectedClass ifNil: [ ^ self ].
	newName := #'instance creation'.
	self selectedClass organization addCategory: newName before: self selectedCategory.
	self resetCategoriesListSelection.
	categoryWidget selectProtocol: newName.
	self selectedCategory: newName.
	self
		updateCategoryAndMethodList;
		giveFocusToSourceCodeArea