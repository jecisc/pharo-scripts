initialization
setRandomBackground
	<script>
	| files |
	files := (StartupPreferencesLoader preferencesGeneralFolder / 'SettingRessources' / 'backgrounds') allFiles.
	PolymorphSystemSettings desktopImageFileName: (files at: UUIDGenerator default makeSeed \\ files size + 1) fullName