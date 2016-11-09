initialization
debuggerUpdate
	<script>
	Smalltalk tools debugger enableStackColoring: true.
	Smalltalk tools debugger alwaysOpenFullDebugger: true.
	GLMMorphicActionRenderer
		compile:
			((GLMMorphicActionRenderer >> #render:) sourceCode
				copyReplaceAll: 'setBalloonText: (anAction title'
				with: 'setBalloonText: (anAction title asString').
	{RestartDebugAction.
	ResumeDebugAction.
	StepIntoDebugAction.
	StepOverDebugAction.
	StepThroughDebugAction.
	GTRunToSelectionDebugAction}
		do: [ :each | 
			each class
				compile:
					(String
						streamContents: [ :s | 
							s
								<< ((each class >> #gtStackDebuggingActionFor:) sourceCode copyUpThrough: $>);
								cr;
								<< '	<gtCustomDebuggingAction>';
								<< ((each class >> #gtStackDebuggingActionFor:) sourceCode copyAfter: $>) ])
				classified: '*PharoSettings5' ]