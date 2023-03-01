Extension { #name : #MenubarItemMorph }

{ #category : #'*PharoSettings7' }
MenubarItemMorph >> minHeight [
	"I do not like small bar"

	^ super minHeight + 10
]
