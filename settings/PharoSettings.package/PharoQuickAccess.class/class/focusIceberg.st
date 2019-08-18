actions
focusIceberg
	(self currentWorld windowsSatisfying: [ :window | window label = 'Repositories' ])
		ifEmpty: [ [ IceTipRepositoriesBrowser new openWithSpec ]
				on: Error
				do: [ self inform: 'Opening Iceberg only works in Pharo >= 7' ] ]
		ifNotEmpty: [ :repos | 
			| window |
			window := repos first.
			window isMinimized ifTrue: [ window restore ] ifFalse: [ window activate ] ]