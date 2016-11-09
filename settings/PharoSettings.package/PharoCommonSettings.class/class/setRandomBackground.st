initialization
setRandomBackground
	<script>
	| files |
	files := (self resourcesFolder / 'backgrounds') allFiles.
	PolymorphSystemSettings desktopImageFileName: (files at: UUIDGenerator default makeSeed \\ files size + 1) fullName