*PharoSettings
isReadAtLeastOnce
	^ self declaringScope allChildren noneSatisfy: [ :node | node isTemp and: [ node name = self name and: [ node isRead ] ] ]