"
I am a utility of the utilities bar listing the MCP servers of the image with their port and their state (see PharoMCPServersPresenter).
"
Class {
	#name : 'PharoMCPServersUtility',
	#superclass : 'UtilitiesBarUtility',
	#instVars : [
		'presenter'
	],
	#category : 'PharoSettings-Utilities',
	#package : 'PharoSettings-Utilities'
}

{ #category : 'building' }
PharoMCPServersUtility >> buildContent [
	"I keep my presenter to refresh it when my panel is displayed, since MCP may have been loaded or its servers changed since the panel was built."

	presenter := self newPresenter.
	^ presenter build
]

{ #category : 'events' }
PharoMCPServersUtility >> displayed [

	presenter refresh
]

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
