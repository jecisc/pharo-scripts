initialization
installFurro
	<script>
	self registerIfPresentProjectOf: 'jecisc' named: 'Furro'.
	Deprecation raiseWarning: false.
	Metacello new
		baseline: #Furro;
		githubUser: 'jecisc'
			project: 'Furro'
			commitish: 'master'
			path: 'src';
		load