Extension { #name : 'PackageOrganizer' }

{ #category : '*PharoSettings' }
PackageOrganizer class >> includingSubstring: aString [
	^ self default packages select: [ :p | p name includesSubstring: aString ]
]

{ #category : '*PharoSettings' }
PackageOrganizer class >> startingWith: aString [
	^ self default packages select: [ :p | p name beginsWith: aString ]
]
