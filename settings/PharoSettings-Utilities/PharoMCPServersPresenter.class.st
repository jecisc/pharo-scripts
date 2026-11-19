"
I list the MCP servers of the image with a colored dot telling their state: green when running and listening, orange when running without listening or stopped while its socket still listens, gray when stopped.
Below the list, a port input and a button start a new server; port 0 lets the operating system choose a free port.
An image usually has a single server, so the list can be as small as one row (see #allowListToShowOneRow): my panel in the utilities bar can then only show the server and the port input.

If MCP (https://github.com/Evref-BL/MCP) is not loaded, I display a message, disable the server controls and show a button to load it (see PharoSettings12 class >> #installMCP). Refresh updates my widgets in place, so the servers are displayed as soon as MCP is loaded, even when it was loaded after I was built.

Listing the servers costs a full garbage collection (see MCP class >> #allServers), so the list is only refreshed when I am built, after starting a server and when clicking the refresh button. It is never polled.

MCP is not a dependency of my package: the MCP class is looked up in the environment (see #mcpClass) so that I can be loaded without it.

A context menu on a server allows one to inspect it, pause it (closing its socket but keeping its handlers), resume it or stop it (see #serverMenuFor:). The utility refreshes me each time my panel is displayed (see PharoMCPServersUtility >> #displayed).
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
		'loadButton',
		'statusLabel'
	],
	#category : 'PharoSettings-Utilities',
	#package : 'PharoSettings-Utilities'
}

{ #category : 'private' }
PharoMCPServersPresenter >> allowListToShowOneRow [
	"The default style sheet of Spec gives lists a minimum height of 125 pixels. An image usually has a single MCP server, so the list can be as small as one row to keep the panel small in the utilities bar. It is done once I am built because the style is applied to the list after its own widget is built."

	self flag: #morphic.
	serversList withAdapterDo: [ :listAdapter | listAdapter widgetDo: [ :listMorph | listMorph minHeight: listMorph rowHeight ceiling ] ]
]

{ #category : 'layout' }
PharoMCPServersPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  spacing: 4;
		  add: statusLabel expand: false;
		  add: serversList;
		  add: (SpBoxLayout newLeftToRight
				   spacing: 4;
				   vAlignCenter;
				   add: 'Port' expand: false;
				   add: portInput;
				   add: startButton expand: false;
				   add: loadButton expand: false;
				   add: refreshButton expand: false;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : 'private' }
PharoMCPServersPresenter >> do: aBlock [
	"Run an action on a server then display its new state"

	aBlock value.
	self listServers
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

	statusLabel := self newLabel.
	serversList := self newList
		               display: [ :server | self labelFor: server ];
		               displayIcon: [ :server | self dotFor: server ];
		               yourself.
	portInput := self newNumberInput
		             beInteger;
		             minimum: 0;
		             number: 4000;
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
	serversList contextMenu: [ self serverMenuFor: serversList selectedItem ].
	self whenBuiltDo: [ self allowListToShowOneRow ].
	self refresh
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

{ #category : 'private' }
PharoMCPServersPresenter >> listServers [
	"Listing the servers costs a full garbage collection, see the class comment."

	serversList items: (self isMCPLoaded
			 ifTrue: [ self mcpClass allServers ]
			 ifFalse: [ #(  ) ])
]

{ #category : 'accessing' }
PharoMCPServersPresenter >> loadButton [
	^ loadButton
]

{ #category : 'actions' }
PharoMCPServersPresenter >> loadMCP [

	PharoSettings12 installMCP.
	self refresh
]

{ #category : 'accessing' }
PharoMCPServersPresenter >> mcpClass [
	"MCP is not a dependency of my package, so its class is looked up in the environment."

	^ self class environment at: #MCP ifAbsent: [ nil ]
]

{ #category : 'accessing' }
PharoMCPServersPresenter >> portInput [
	^ portInput
]

{ #category : 'actions' }
PharoMCPServersPresenter >> refresh [
	"MCP may have been loaded or its servers may have changed since I was built. The layout is never replaced, since a built layout is not rebuilt, so my widgets are updated in place."

	statusLabel label: (self isMCPLoaded
			 ifTrue: [ '' ]
			 ifFalse: [ 'MCP is not loaded in this image.' ]).
	loadButton enabled: self isMCPLoaded not.
	portInput enabled: self isMCPLoaded.
	startButton enabled: self isMCPLoaded.
	self listServers
]

{ #category : 'menu' }
PharoMCPServersPresenter >> serverMenuFor: aServer [
	"Pausing closes the socket of the server but keeps its handlers and observability, stopping also shuts the observability down. Menu items that are not possible for the state of the server are disabled."

	^ SpMenuPresenter new
		  addItem: [ :item |
				  item
					  name: 'Inspect';
					  action: [ aServer inspect ] ];
		  addItem: [ :item |
				  item
					  name: 'Pause';
					  enabled: aServer isRunning;
					  action: [ self do: [ aServer server stop ] ] ];
		  addItem: [ :item |
				  item
					  name: 'Resume';
					  enabled: aServer isRunning not;
					  action: [ self do: [ aServer start ] ] ];
		  addItem: [ :item |
				  item
					  name: 'Stop';
					  enabled: aServer isRunning;
					  action: [ self do: [ aServer stop ] ] ];
		  yourself
]

{ #category : 'accessing' }
PharoMCPServersPresenter >> serversList [

	^ serversList
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

{ #category : 'accessing' }
PharoMCPServersPresenter >> statusLabel [
	^ statusLabel
]
