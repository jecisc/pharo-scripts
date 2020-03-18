initialization
setRandomBackground
	<script>
	[ | files |
	self shouldBeSFW traceCr.
	files := (self shouldBeSFW ifTrue: [ self backgroundFolder / 'SFW' ] ifFalse: [ self backgroundFolder ]) allFiles.
	files := files reject: [ :f | f beginsWith: '.' ].
	PolymorphSystemSettings desktopImageFileName: (files at: UUID new asInteger \\ files size + 1) fullName ] fork