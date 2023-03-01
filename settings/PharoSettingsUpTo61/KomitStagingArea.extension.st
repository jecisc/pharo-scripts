Extension { #name : #KomitStagingArea }

{ #category : #'*PharoSettingsUpTo61' }
KomitStagingArea >> remotesAlt [
	| result |
	self packages ifEmpty: [ ^ #() ].
	result := self packages first remotes.
	self packages allButFirst do: [ :each | result := result intersection: each remotes ].
	^ result collect: [ :each | each koRemote ]
]
