initialization
installQuickAccess
	<script>
	| sourcesDir |
	sourcesDir := (self sharedRepositoryFolder / 'jecisc' / 'QuickAccess' / 'src').

	sourcesDir exists ifFalse: [ UIManager default alert: 'Clone QuickAccess for to ', sourcesDir parent parent fullName ].

	Metacello new
		baseline: 'QuickAccess';
		repository: 'tonel://' , sourcesDir fullName;
		load: #(#Tools).

	(self environment classNamed: #QACActionManager) importFile: self resourcesFolder / 'quickAccess.qac'