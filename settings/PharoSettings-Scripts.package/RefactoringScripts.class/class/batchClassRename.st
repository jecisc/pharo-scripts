class refactoring
batchClassRename
	<script>
	self open: '	classes := (RPackageOrganizer includingSubstring: ''Name'') flatCollect: #definedClasses.
oldPrefix := ''old''.
newPrefix := ''new''.

classes
	do: [ :class | (class name beginsWith: oldPrefix) ifTrue: [ (RBRenameClassRefactoring rename: class name to: newPrefix , (class name withoutPrefix: oldPrefix)) execute ] ]'