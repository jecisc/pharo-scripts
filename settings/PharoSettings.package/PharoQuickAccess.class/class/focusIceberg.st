actions
focusIceberg
	"This method will look for an open tip repository browser open (This is the entry point of Iceberg). If one is open, bring it to front. Else, open one."

	(self currentWorld windowsSatisfying: [ :window | window label = 'Repositories' ])
		ifEmpty: [ [ IceTipRepositoriesBrowser new openWithSpec ]
				on: Error
				do: [ self inform: 'Opening Iceberg only works in Pharo >= 7' ] ]
		ifNotEmpty: [ :repos |
			| window |
			window := repos first.
			window isMinimized ifTrue: [ window restore ] ifFalse: [ window activate ] ]