Extension { #name : #SHRBTextStyler }

{ #category : #'*PharoSettingsUpTo8' }
SHRBTextStyler >> altVisitLiteralValueNode: anArray [
	| aLiteralValueNode value link |
	aLiteralValueNode := anArray first.
	value := aLiteralValueNode value.
	
	
	"We can have 3 different kind of links from a literal: 
	- In case it is a symbol representing a class, we want to return a TextClassLink to browse the class or its references
	- In case it is another symbol, we want to return a TextMethodLink to browser the implementors or senders of this selector
	- In case it is another literal value, we return a TextClassLink to browse the class defining this litera."
	link := value isSymbol
		ifTrue: [
			self class environment
				at: value
				ifPresent: [ :class | TextClassLink class: class ]
				ifAbsent: [ TextMethodLink selector: value ] ]
		ifFalse: [ TextClassLink class: value class ].
	self addStyle: (self literalStyleSymbol: value) attribute: link forNode: aLiteralValueNode
]
