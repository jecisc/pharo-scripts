Extension { #name : #ClyBrowserMorph }

{ #category : #'*PharoSettings' }
ClyBrowserMorph >> altWindowIsClosing [
	navigationViews do: [ :each | each windowIsClosing ].
	tabManager windowIsClosing
]
