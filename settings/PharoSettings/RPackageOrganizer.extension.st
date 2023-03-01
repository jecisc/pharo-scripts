Extension { #name : #RPackageOrganizer }

{ #category : #'*PharoSettings' }
RPackageOrganizer class >> includingSubstring: aString [
	^ self default packages select: [ :p | p name includesSubstring: aString ]
]

{ #category : #'*PharoSettings' }
RPackageOrganizer class >> startingWith: aString [
	^ self default packages select: [ :p | p name beginsWith: aString ]
]
