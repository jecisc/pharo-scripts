*PharoSettings7
selectOrigin
	remotePanel remoteList listItems
		detect: [ :e | e name = 'origin' ]
		ifFound: [ :remote | remotePanel remoteList selectedItem: remote ]