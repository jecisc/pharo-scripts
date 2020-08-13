class refactoring
batchClassRename
	| classes oldPrefix newPrefix |
	classes := (RPackageOrganizer includingSubstring: 'Name') flatCollect: #definedClasses.
	oldPrefix := 'old'.
	newPrefix := 'new'.

	classes
		do: [ :class | (class name beginsWith: oldPrefix) ifTrue: [ (RBRenameClassRefactoring rename: class to: newPrefix , (class name withoutPrefix: oldPrefix)) execute ] ]