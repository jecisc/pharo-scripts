initialization
installQuickAccess
	<script>
	
	| sourcesDir |
	sourcesDir := (StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories' / 'jecisc' / 'QuickAccessOld' / 'src').

	sourcesDir exists ifFalse: [ UIManager default alert: 'Clone QuickAccess old (commit 264b98edb7d6c9ca0f9f86340aae37405e2869f5) for to ', sourcesDir parent parent fullName ].

	Metacello new
		baseline: 'QuickAccess';
		repository: 'tonel://' , sourcesDir fullName;
		load: #(#Tools).

	(self environment classNamed: #QACActionManager) importFile: StartupPreferencesLoader preferencesGeneralFolder / 'SettingRessources' / 'quickAccess.qac'