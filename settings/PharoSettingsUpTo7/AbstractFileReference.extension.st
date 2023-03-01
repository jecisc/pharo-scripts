Extension { #name : #AbstractFileReference }

{ #category : #'*PharoSettingsUpTo7' }
AbstractFileReference >> openInOSFileBrowser [
	^ self openInNativeBrowser
]
