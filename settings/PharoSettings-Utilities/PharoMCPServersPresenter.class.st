"
I list the MCP servers of the image with a colored dot telling their state: green when running and listening, orange when running without listening or stopped while its socket still listens, gray when stopped.
Below the list, a port input and a button start a new server; port 0 lets the operating system choose a free port.

If MCP (https://github.com/Evref-BL/MCP) is not loaded, I only display a button to load it (see PharoSettings12 class >> #installMCP).

Listing the servers costs a full garbage collection (see MCP class >> #allServers), so the list is only refreshed when I am built, after starting a server and when clicking the refresh button. It is never polled.

MCP is not a dependency of my package: the MCP class is looked up in the environment (see #mcpClass) so that I can be loaded without it.
"
Class {
	#name : 'PharoMCPServersPresenter',
	#superclass : 'SpPresenter',
	#traits : 'TPharoStatusDot',
	#classTraits : 'TPharoStatusDot classTrait',
	#instVars : [
		'serversList',
		'portInput',
		'startButton',
		'refreshButton',
		'loadButton'
	],
	#category : 'PharoSettings-Utilities',
	#package : 'PharoSettings-Utilities'
}

{ #category : 'layout' }
PharoMCPServersPresenter >> defaultLayout [

	self isMCPLoaded ifFalse: [
			^ SpBoxLayout newTopToBottom
				  spacing: 4;
				  add: 'MCP is not loaded in this image.' expand: false;
				  add: loadButton expand: false;
				  yourself ].
	^ SpBoxLayout newTopToBottom
		  spacing: 4;
		  add: serversList;
		  add: (SpBoxLayout newLeftToRight
				   spacing: 4;
				   vAlignCenter;
				   add: 'Port' expand: false;
				   add: portInput;
				   add: startButton expand: false;
				   add: refreshButton expand: false;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : 'displaying' }
PharoMCPServersPresenter >> dotColorFor: aServer [
	"Green when everything is fine, orange when the server and its socket disagree, gray when stopped."

	(aServer isRunning and: [ aServer isListening ]) ifTrue: [ ^ Color green ].
	(aServer isRunning or: [ aServer isListening ]) ifTrue: [ ^ Color orange ].
	^ Color gray
]

{ #category : 'initialization' }
PharoMCPServersPresenter >> initializePresenters [

	serversList := self newList
		               display: [ :server | self labelFor: server ];
		               displayIcon: [ :server | self dotFor: server ];
		               yourself.
	portInput := self newNumberInput
		             beInteger;
		             minimum: 0;
		             number: 0;
		             yourself.
	startButton := self newButton
		               label: 'Start';
		               icon: (self iconNamed: #smallDoIt);
		               help: 'Start an MCP server on this port. Port 0 lets the operating system choose a free port.';
		               action: [ self startServer ];
		               yourself.
	refreshButton := self newButton
		                 icon: (self iconNamed: #glamorousRefresh);
		                 help: 'Refresh the list of servers';
		                 action: [ self refresh ];
		                 yourself.
	loadButton := self newButton
		              label: 'Load MCP';
		              icon: (self iconNamed: #smallLoadProject);
		              action: [ self loadMCP ];
		              yourself.
	self isMCPLoaded ifTrue: [ self refresh ]
]

{ #category : 'accessing' }
PharoMCPServersPresenter >> isMCPLoaded [

	^ self mcpClass isNotNil
]

{ #category : 'displaying' }
PharoMCPServersPresenter >> labelFor: aServer [

	^ String streamContents: [ :stream |
			  stream
				  nextPutAll: 'MCP on port ';
				  print: aServer port;
				  nextPutAll: ' (';
				  nextPutAll: (self stateOf: aServer);
				  nextPut: $) ]
]

{ #category : 'actions' }
PharoMCPServersPresenter >> loadMCP [

	PharoSettings12 installMCP.
	self isMCPLoaded ifFalse: [ ^ self ].
	self refresh.
	self layout: self defaultLayout
]

{ #category : 'accessing' }
PharoMCPServersPresenter >> mcpClass [
	"MCP is not a dependency of my package, so its class is looked up in the environment."

	^ self class environment at: #MCP ifAbsent: [ nil ]
]

{ #category : 'actions' }
PharoMCPServersPresenter >> refresh [
	"Listing the servers costs a full garbage collection, see the class comment."

	serversList items: self mcpClass allServers
]

{ #category : 'actions' }
PharoMCPServersPresenter >> startServer [

	self mcpClass startOnPort: portInput number.
	self refresh
]

{ #category : 'displaying' }
PharoMCPServersPresenter >> stateOf: aServer [
	"Running and listening are two facts: a server whose socket died is still running, and a socket that outlived its server still holds the port."

	aServer isRunning ifFalse: [
			^ aServer isListening
				  ifTrue: [ 'stopped, socket still listening' ]
				  ifFalse: [ 'stopped' ] ].
	^ aServer isListening
		  ifTrue: [ 'running' ]
		  ifFalse: [ 'running, socket not listening' ]
]
