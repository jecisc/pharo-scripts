initialization
enableStackColoring
	<script>
	SystemVersion current major < 9 ifTrue: [ Smalltalk tools debugger enableStackColoring: true. ] ifFalse: [ self inform: 'Stack coloring is not yet in the debugger. Ask for it later.' ]