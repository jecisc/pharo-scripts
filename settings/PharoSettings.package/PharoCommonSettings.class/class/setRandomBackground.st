initialization
setRandomBackground
	<script>
	[ | files |
	files := self backgroundFolder allFiles.
	PolymorphSystemSettings desktopImageFileName: (files at: UUID new asInteger \\ files size + 1) fullName ] fork