Extension { #name : 'PlatformResolver' }

{ #category : '*PharoSettings' }
PlatformResolver >> googleDrive [
	<origin>
	^ self home / 'Google Drive'
]

{ #category : '*PharoSettings' }
PlatformResolver >> protonDrive [

	<origin>
	^ self home / 'Library/CloudStorage/ProtonDrive-cyril@ferlicot.fr'
]
