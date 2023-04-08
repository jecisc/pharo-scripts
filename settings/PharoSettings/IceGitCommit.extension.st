Extension { #name : #IceGitCommit }

{ #category : #'*PharoSettings' }
IceGitCommit >> projectAlt [
	^ [ IceProjectReader readProjectFrom: self ]
		on: NotFound
		do: [ self repository fetch.
			IceProjectReader readProjectFrom: self ]
]
