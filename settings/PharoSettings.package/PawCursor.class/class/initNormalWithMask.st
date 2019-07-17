initialization - private
initNormalWithMask
	"Cursor initNormalWithMask.  Cursor normal show"

	"Next two lines work simply for any cursor..."

	self initNormal.
	NormalCursor := CursorWithMask derivedFrom: NormalCursor