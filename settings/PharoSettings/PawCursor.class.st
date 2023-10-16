"
A cursor looking like a paw.
"
Class {
	#name : 'PawCursor',
	#superclass : 'Cursor',
	#category : 'PharoSettings',
	#package : 'PharoSettings'
}

{ #category : 'query' }
PawCursor class >> beCurrent [
	self initNormalWithMask
]

{ #category : 'initialization - private' }
PawCursor class >> initNormal [
	NormalCursor :=
		(Cursor
			extent: 16@16
			fromArray: #(
		2r0000000000000
		2r0000110000000
		2r0000111100000
		2r0011111111000
		2r0011111111100
		2r0011111111100
		2r0001100011100
		2r0111001101100
		2r1111011111100
		2r1111011111110
		2r0111111111110
		2r0000111111000
		2r0000111100000
		2r0000111000000
		2r0000000000000
		2r0000000000000)
	offset: 0@0)
]

{ #category : 'initialization - private' }
PawCursor class >> initNormalWithMask [
	"Cursor initNormalWithMask.  Cursor normal show"

	"Next two lines work simply for any cursor..."

	self initNormal.
	NormalCursor := CursorWithMask derivedFrom: NormalCursor
]
