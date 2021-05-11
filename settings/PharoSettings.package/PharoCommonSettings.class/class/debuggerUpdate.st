initialization
debuggerUpdate
	<script>
	SystemVersion current major < 9 ifTrue: [ Smalltalk tools debugger enableStackColoring: true. ] ifFalse: [ self inform: 'Stack coloring is not yet in the debugger. Ask for it later.' ].
	
	GLMMorphicActionRenderer compile: ((GLMMorphicActionRenderer >> #render:) sourceCode copyReplaceAll: 'setBalloonText: (anAction title' with: 'setBalloonText: (anAction title asString')