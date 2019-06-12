initialization
ensurePlayground
	"I want the normal playground..."

	<script>
	Smalltalk tools workspaceTool name = #MoosePlayground ifTrue: [ Smalltalk tools workspaceTool: GTPlayground ]