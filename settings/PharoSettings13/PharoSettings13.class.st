Class {
	#name : 'PharoSettings13',
	#superclass : 'PharoAbstractSettings',
	#category : 'PharoSettings13',
	#package : 'PharoSettings13'
}

{ #category : 'class initialization' }
PharoSettings13 class >> initFileBrowserSettings [

	<script>
	StFileBrowserSettings
		showHiddenFiles: true;
		openOnLastDirectory: true.

	[
		StFileSystemModel addBookmarkNamed: 'pharo' location: FileLocator preferences / 'pharo' iconName: #git.
		StFileSystemModel
			addBookmarkNamed: 'Proton drive'
			location: '/Users/cyril/Library/CloudStorage/ProtonDrive-cyril@ferlicot.fr' asFileReference
			iconName: #package ]
		on: Error
		do: [ self flag: #todo "This should be removed once the feature is merged in NewTools." ]
]

{ #category : 'class initialization' }
PharoSettings13 class >> initialize [

	self
		initializeTheme;
		initFileBrowserSettings
]

{ #category : 'class initialization' }
PharoSettings13 class >> initializeTheme [

	<script>
	BlockStyler defaultThemes at: DarkBlueTheme put: (Color lightBlue alpha: 0.05).
	DarkBlueTheme beCurrent
]

{ #category : 'see class side' }
PharoSettings13 >> seeClassSide [
]
