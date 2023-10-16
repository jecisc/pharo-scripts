Extension { #name : 'MenubarItemMorph' }

{ #category : '*PharoSettings' }
MenubarItemMorph >> minHeight [
	"I do not like small bar"

	^ super minHeight + 10
]
