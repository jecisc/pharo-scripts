initialization
debuggerUpdate
	<script>
	Smalltalk tools debugger enableStackColoring: true.
	self flag: #pharo7.	"full debugger is the defaul in Pharo 8."
	[ Smalltalk tools debugger alwaysOpenFullDebugger: true ]
		on: MessageNotUnderstood
		do: [  ].
	GLMMorphicActionRenderer compile: ((GLMMorphicActionRenderer >> #render:) sourceCode copyReplaceAll: 'setBalloonText: (anAction title' with: 'setBalloonText: (anAction title asString')