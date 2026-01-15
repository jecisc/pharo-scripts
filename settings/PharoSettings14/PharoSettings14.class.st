Class {
	#name : 'PharoSettings14',
	#superclass : 'PharoAbstractSettings',
	#category : 'PharoSettings14',
	#package : 'PharoSettings14'
}

{ #category : 'class initialization' }
PharoSettings14 class >> disableRefactoringPreviews [

	<script>
	{ #ReDuplicateClassDriver. #ReGenerateEqualAndHashDriver. #ReGeneratePrintOnDriver. #ReMoveMethodsToClassSideDriver. #ReRemoveClassDriver. #ReRemoveMethodDriver.
	#ReRemoveInstanceVariablesDriver. #ReRemoveSharedVariablesDriver. #ReRenameArgumentOrTemporaryDriver. #ReRenameInstanceVariableDriver.
	#ReRenameSharedVariableDriver } do: [ :class |
			self environment
				at: class
				ifPresent: [ :aClass | aClass shouldPreviewChanges: false ]
				ifAbsent: [ InformativeNotification signal: 'Missing class ' , class ] ]
]

{ #category : 'class initialization' }
PharoSettings14 class >> initFileBrowserSettings [

	<script>
	StFileSystemModel addBookmarkNamed: 'pharo' location: FileLocator preferences / 'pharo' iconName: #git.
	StFileSystemModel
		addBookmarkNamed: 'Proton drive'
		location: '/Users/cyril/Library/CloudStorage/ProtonDrive-cyril@ferlicot.fr' asFileReference
		iconName: #package
]

{ #category : 'class initialization' }
PharoSettings14 class >> initialize [

	self
		initFileBrowserSettings;
		disableRefactoringPreviews
]

{ #category : 'see class side' }
PharoSettings14 >> seeClassSide [ 
]
