initialization
setRandomBackground
	<script>
	[ | files |
	files := self backgroundFolder allFiles.
	PolymorphSystemSettings
		desktopImageFileName:
			(files
				at:
					([ UUIDGenerator default makeSeed ]
						on: MessageNotUnderstood
						do: [ UUIDGenerator default next asInteger ]) \\ files size + 1) fullName ] fork