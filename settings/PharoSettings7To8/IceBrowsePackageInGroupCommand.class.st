Class {
	#name : #IceBrowsePackageInGroupCommand,
	#superclass : #IceTipRepositoryCommand,
	#category : 'PharoSettings7To8'
}

{ #category : #activation }
IceBrowsePackageInGroupCommand class >> browserContextActivation [
	<classAnnotation>
	
	"The Default option when double clicking should be the first in the menu"
	^ CmdContextMenuActivation 
		byRootGroupItemOrder: 1
		for: IceTipRepositoryListContext
]

{ #category : #activation }
IceBrowsePackageInGroupCommand class >> defaultHelp [
	^ 'Open packages manager browser for this repository in a group'
]

{ #category : #activation }
IceBrowsePackageInGroupCommand class >> defaultMenuIconName [
	^ #package
]

{ #category : #testing }
IceBrowsePackageInGroupCommand class >> defaultMenuItemName [
	^ 'Packages in group'
]

{ #category : #execution }
IceBrowsePackageInGroupCommand >> execute [
	| group |
	group := (self currentWorld windowsSatisfying: [ :w | w label = 'Iceberg Repositories' ])
		ifEmpty: [ | g |
			g := GroupWindowMorph new.
			(g openInWindowLabeled: 'Iceberg Repositories') extent: 1200 @ 800.
			g ]
		ifNotEmpty: [ :ws | 
			| window |
			window := ws first.
			window isMinimized
				ifTrue: [ window restore ]
				ifFalse: [ window activate ]. window paneMorphs first ].
	group addWindow: (IceTipWorkingCopyBrowser on: self repositoryModel) openWithSpec window
]
