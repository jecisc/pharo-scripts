Class {
	#name : #ClyMakeAbstractCommand,
	#superclass : #SycSingleClassCommand,
	#category : #PharoSettings
}

{ #category : #activation }
ClyMakeAbstractCommand class >> fullBrowserMenuActivation [
	<classAnnotation>

	^ CmdContextMenuActivation for: ClyClassContextOfFullBrowser
]

{ #category : #activation }
ClyMakeAbstractCommand class >> fullBrowserShortcutActivation [
	<classAnnotation>

	^ CmdShortcutActivation by: $m meta, $a meta for: ClyClassContextOfFullBrowser
]

{ #category : #accessing }
ClyMakeAbstractCommand >> defaultMenuIconName [
	^ #abstract
]

{ #category : #accessing }
ClyMakeAbstractCommand >> defaultMenuItemName [
	^ 'Make abstract'
]

{ #category : #execution }
ClyMakeAbstractCommand >> execute [
	targetClass class
		compile:
			'isAbstract
	^ self = ' , targetClass name
		classified: 'testing'
]
