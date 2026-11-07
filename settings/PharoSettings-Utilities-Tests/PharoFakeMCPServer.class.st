"
I replace an MCP server in the tests of PharoMCPServersPresenter, answering a port and whether I am running and listening.
"
Class {
	#name : 'PharoFakeMCPServer',
	#superclass : 'Object',
	#instVars : [
		'port',
		'running',
		'listening'
	],
	#category : 'PharoSettings-Utilities-Tests',
	#package : 'PharoSettings-Utilities-Tests'
}

{ #category : 'instance creation' }
PharoFakeMCPServer class >> port: anInteger running: isRunning listening: isListening [

	^ self new
		  setPort: anInteger running: isRunning listening: isListening;
		  yourself
]

{ #category : 'accessing' }
PharoFakeMCPServer >> isListening [

	^ listening
]

{ #category : 'accessing' }
PharoFakeMCPServer >> isRunning [

	^ running
]

{ #category : 'accessing' }
PharoFakeMCPServer >> port [

	^ port
]

{ #category : 'initialization' }
PharoFakeMCPServer >> setPort: anInteger running: isRunning listening: isListening [

	port := anInteger.
	running := isRunning.
	listening := isListening
]
