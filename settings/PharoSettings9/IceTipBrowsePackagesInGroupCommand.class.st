"
I'm a command to open the package manager browser for a project.
"
Class {
	#name : 'IceTipBrowsePackagesInGroupCommand',
	#superclass : 'IceTipRepositoryCommand',
	#category : 'PharoSettings9',
	#package : 'PharoSettings9'
}

{ #category : 'accessing - defaults' }
IceTipBrowsePackagesInGroupCommand class >> defaultDescription [
	^ 'Open packages manager browser for this repository in a group'
]

{ #category : 'accessing - defaults' }
IceTipBrowsePackagesInGroupCommand class >> defaultName [
	^ 'Packages in group'
]

{ #category : 'executing' }
IceTipBrowsePackagesInGroupCommand >> execute [

	| group |
	group := (self currentWorld windowsSatisfying: [ :w | w label = 'Iceberg Repositories' ])
		         ifEmpty: [
			         | g |
			         g := GroupWindowMorph new.
			         (g openInWindowLabeled: 'Iceberg Repositories') extent: 1200 @ 800.
			         g ]
		         ifNotEmpty: [ :ws |
			         | window |
			         window := ws first.
			         window isMinimized
				         ifTrue: [ window restore ]
				         ifFalse: [ window activate ].
			         window paneMorphs first ].
	group addWindow: (SystemVersion current major < 10
			 ifTrue: [ (IceTipWorkingCopyBrowser on: self repositoryModel) openWithSpec ]
			 ifFalse: [ (IceTipWorkingCopyBrowser on: self repositoryModel) open ]) window
]

{ #category : 'accessing' }
IceTipBrowsePackagesInGroupCommand >> iconName [
	^ #package
]

{ #category : 'accessing' }
IceTipBrowsePackagesInGroupCommand >> shortcutKey [
	^ $i meta
]
