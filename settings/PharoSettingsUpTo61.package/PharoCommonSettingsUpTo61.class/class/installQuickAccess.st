initialization
installQuickAccess
	<script>
	
	| sourcesDir |
	sourcesDir := (StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories' / 'jecisc' / 'QuickAccessOld' / 'src').

	sourcesDir exists ifFalse: [ UIManager default alert: 'Clone QuickAccess old (oldPharo branch) for to ', sourcesDir parent parent fullName ].

	Metacello new
		baseline: 'QuickAccess';
		repository: 'tonel://' , sourcesDir fullName;
		load: #(#Tools).

	(self environment classNamed: #QACActionManager) importFile: StartupPreferencesLoader preferencesGeneralFolder / 'SettingRessources' / 'quickAccess.qac'