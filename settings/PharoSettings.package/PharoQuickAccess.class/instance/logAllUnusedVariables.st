conveniance
logAllUnusedVariables
	<name: #'Log all unused variables'>
	Transcript clear; open.
	Object
		allSubclassesDo: [ :class | 
			class instVarNames
				do: [ :each | (class whichSelectorsAccess: each) size = 0 ifTrue: [ Transcript crShow: 'Class: ' , class printString , ' var: ' , each ] ] ]