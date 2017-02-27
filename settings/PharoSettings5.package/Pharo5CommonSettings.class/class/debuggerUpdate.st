initialization
debuggerUpdate
	<script>
	Smalltalk tools debugger enableStackColoring: true.
	Smalltalk tools debugger alwaysOpenFullDebugger: true.
	GLMMorphicActionRenderer compile: ((GLMMorphicActionRenderer >> #render:) sourceCode copyReplaceAll: 'setBalloonText: (anAction title' with: 'setBalloonText: (anAction title asString')