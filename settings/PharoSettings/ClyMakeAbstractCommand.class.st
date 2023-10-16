"
A simple command to generate the #isAbstract method.
"
Class {
	#name : 'ClyMakeAbstractCommand',
	#superclass : 'SycSingleClassCommand',
	#category : 'PharoSettings',
	#package : 'PharoSettings'
}

{ #category : 'activation' }
ClyMakeAbstractCommand class >> fullBrowserMenuActivation [

	<classAnnotation>
	^ CmdContextMenuActivation for: (Smalltalk at: #ClyClassContextOfFullBrowser ifAbsent: [ Smalltalk at: #ClyFullBrowserClassContext ])
]

{ #category : 'activation' }
ClyMakeAbstractCommand class >> fullBrowserShortcutActivation [

	<classAnnotation>
	^ CmdShortcutActivation by: $m meta , $a meta for: (Smalltalk at: #ClyClassContextOfFullBrowser ifAbsent: [ Smalltalk at: #ClyFullBrowserClassContext ])
]

{ #category : 'accessing' }
ClyMakeAbstractCommand >> defaultMenuIconName [
	^ #abstract
]

{ #category : 'accessing' }
ClyMakeAbstractCommand >> defaultMenuItemName [
	^ 'Make abstract'
]

{ #category : 'execution' }
ClyMakeAbstractCommand >> execute [
	targetClass class
		compile:
			'isAbstract
	^ self = ' , targetClass name
		classified: 'testing'
]
