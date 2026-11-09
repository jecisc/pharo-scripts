"
I am a PharoMCPServersPresenter whose MCP becomes loaded on demand (see #loadMCPNow), to test a presenter that was built before MCP was loaded. I am my own MCP class and answer a single fake server.
"
Class {
	#name : 'PharoMCPLateLoadedPresenter',
	#superclass : 'PharoMCPServersPresenter',
	#instVars : [
		'mcpLoaded'
	],
	#category : 'PharoSettings-Utilities-Tests',
	#package : 'PharoSettings-Utilities-Tests'
}

{ #category : 'private' }
PharoMCPLateLoadedPresenter >> allServers [

	^ { (PharoFakeMCPServer port: 4000 running: true listening: true) }
]

{ #category : 'actions' }
PharoMCPLateLoadedPresenter >> loadMCPNow [

	mcpLoaded := true
]

{ #category : 'private' }
PharoMCPLateLoadedPresenter >> mcpClass [

	^ mcpLoaded == true ifTrue: [ self ]
]
