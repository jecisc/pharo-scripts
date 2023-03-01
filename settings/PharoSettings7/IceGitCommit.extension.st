Extension { #name : #IceGitCommit }

{ #category : #'*PharoSettings7' }
IceGitCommit >> projectAlt [
	^ [ IceProjectReader readProjectFrom: self ]
		on: NotFound
		do: [ self repository fetch.
			IceProjectReader readProjectFrom: self ]
]
