"
I draw the small colored dot telling the status of an item in the lists of my utilities (MCP servers, repositories, processes).
My users answer the color of the dot of an item with #dotColorFor:.
"
Trait {
	#name : 'TPharoStatusDot',
	#category : 'PharoSettings-Utilities',
	#package : 'PharoSettings-Utilities'
}

{ #category : 'displaying' }
TPharoStatusDot >> dotColorFor: anObject [

	^ self explicitRequirement
]

{ #category : 'displaying' }
TPharoStatusDot >> dotFor: anObject [

	| form |
	form := Form extent: 12 @ 12 depth: 32.
	form fillColor: Color transparent.
	form getCanvas fillOval: (1 @ 1 extent: 10 @ 10) color: (self dotColorFor: anObject).
	^ form
]
