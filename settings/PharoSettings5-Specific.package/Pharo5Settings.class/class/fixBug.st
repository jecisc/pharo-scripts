initialization
fixBug

	<script>
	GLMMorphicActionRenderer compile:
		((GLMMorphicActionRenderer >> #render:) sourceCode copyReplaceAll: 'setBalloonText: (anAction title' with: 'setBalloonText: (anAction title asString')