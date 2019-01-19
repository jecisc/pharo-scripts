loading
installGeometry
	<name: #'Install Geometry'>

	Metacello new
		baseline: #Geometry;
		githubUser: 'TelescopeSt' project: 'Geometry' commitish: 'master' path: 'src';
		load