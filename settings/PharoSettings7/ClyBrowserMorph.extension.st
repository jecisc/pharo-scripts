Extension { #name : #ClyBrowserMorph }

{ #category : #'*PharoSettings7' }
ClyBrowserMorph >> altWindowIsClosing [
	navigationViews do: [ :each | each windowIsClosing ].
	tabManager windowIsClosing
]
