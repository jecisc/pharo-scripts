Extension { #name : #WindowsResolver }

{ #category : #'*PharoSettings8' }
WindowsResolver >> googleDrive [

	"I have 2 windows so I try both"

	<origin>
	| firstOrigin |
	firstOrigin := FileLocator C / 'Users\jecis\GoogleDrive'.
	^ firstOrigin exists
		  ifTrue: [ firstOrigin ]
		  ifFalse: [ FileLocator E / 'GoogleDrive' ]
]
