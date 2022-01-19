templates
batchRenameClasses
	<name: #'Batch classes rename'>
	self openOn:
			'classes := ''JenkinsBuilder'' asPackage definedClasses.
oldPrefix := ''SB''.
newPrefix := ''JB''.

classes do: [ :class | (RBRenameClassRefactoring rename: class to: newPrefix , (class name withoutPrefix: oldPrefix)) execute ]'