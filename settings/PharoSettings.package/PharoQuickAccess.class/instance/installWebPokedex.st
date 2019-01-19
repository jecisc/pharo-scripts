loading
installWebPokedex
	<name: #'Install WebPokedex'>
	Metacello new
		baseline: #WebPokedex;
		githubUser: 'jecisc'
			project: 'WebPokedex'
			commitish: 'development'
			path: 'src';
		onWarningLog;
		load.

	(Smalltalk at: #WPServer) readStonModelWithContextFile: '../../GitRepositories/WebPokedex/Ressources/devContext.ston'