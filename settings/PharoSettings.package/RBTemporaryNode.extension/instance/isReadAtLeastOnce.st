*PharoSettings
isReadAtLeastOnce
	self flag: #todo.	"https://github.com/pharo-project/pharo/issues/6001"
	^ self declaringScope allChildren noneSatisfy: [ :node | (node isKindOf: RBTemporaryNode) and: [ node name = self name and: [ node isRead ] ] ]