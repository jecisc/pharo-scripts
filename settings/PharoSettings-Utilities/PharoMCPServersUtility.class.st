"
I am a utility of the utilities bar listing the MCP servers of the image with their port and their state (see PharoMCPServersPresenter).
"
Class {
	#name : 'PharoMCPServersUtility',
	#superclass : 'UtilitiesBarUtility',
	#category : 'PharoSettings-Utilities',
	#package : 'PharoSettings-Utilities'
}

{ #category : 'building' }
PharoMCPServersUtility >> newPresenter [

	^ PharoMCPServersPresenter new
]

{ #category : 'accessing' }
PharoMCPServersUtility >> priority [

	^ 10
]

{ #category : 'accessing' }
PharoMCPServersUtility >> title [

	^ 'MCP'
]
