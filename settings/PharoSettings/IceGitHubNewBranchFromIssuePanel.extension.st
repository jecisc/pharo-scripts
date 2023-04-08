Extension { #name : #IceGitHubNewBranchFromIssuePanel }

{ #category : #'*PharoSettings' }
IceGitHubNewBranchFromIssuePanel >> selectOrigin [
	remotePanel remoteList listItems
		detect: [ :e | e name = 'origin' ]
		ifFound: [ :remote |
			[ remotePanel remoteList selectedItem: remote ]
				on: MessageNotUnderstood
				do: [ SystemVersion current major < 9
						ifTrue: [ remotePanel remoteList setSelectedItem: remote ]
						ifFalse: [ remotePanel remoteList selectItem: remote ] ] ]
]
