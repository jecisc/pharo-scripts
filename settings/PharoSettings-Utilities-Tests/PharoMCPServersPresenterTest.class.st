"
I test how PharoMCPServersPresenter displays MCP servers, using fake servers.
"
Class {
	#name : 'PharoMCPServersPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'PharoSettings-Utilities-Tests',
	#package : 'PharoSettings-Utilities-Tests'
}

{ #category : 'running' }
PharoMCPServersPresenterTest >> setUp [

	super setUp.
	presenter := PharoMCPServersPresenter basicNew
]

{ #category : 'tests' }
PharoMCPServersPresenterTest >> testContentCanBeAsSmallAsOneServerAndThePortRow [

	| morph |
	morph := PharoMCPServersPresenter new build.
	morph extent: 340 @ 300.
	morph fullBounds.
	self assert: morph minExtent y < 70
]

{ #category : 'tests' }
PharoMCPServersPresenterTest >> testDotIsGrayWhenStopped [

	self assert: (presenter dotColorFor: (PharoFakeMCPServer port: 4000 running: false listening: false)) equals: Color gray
]

{ #category : 'tests' }
PharoMCPServersPresenterTest >> testDotIsGreenWhenRunningAndListening [

	self assert: (presenter dotColorFor: (PharoFakeMCPServer port: 4000 running: true listening: true)) equals: Color green
]

{ #category : 'tests' }
PharoMCPServersPresenterTest >> testDotIsOrangeWhenRunningWithoutListening [

	self assert: (presenter dotColorFor: (PharoFakeMCPServer port: 4000 running: true listening: false)) equals: Color orange
]

{ #category : 'tests' }
PharoMCPServersPresenterTest >> testDotIsOrangeWhenStoppedButStillListening [

	self assert: (presenter dotColorFor: (PharoFakeMCPServer port: 4000 running: false listening: true)) equals: Color orange
]

{ #category : 'tests' }
PharoMCPServersPresenterTest >> testLabelGivesThePortAndTheState [

	self assert: (presenter labelFor: (PharoFakeMCPServer port: 4000 running: true listening: true)) equals: 'MCP on port 4000 (running)'.
	self assert: (presenter labelFor: (PharoFakeMCPServer port: 4001 running: false listening: false)) equals: 'MCP on port 4001 (stopped)'.
	self assert: (presenter labelFor: (PharoFakeMCPServer port: 4002 running: true listening: false)) equals: 'MCP on port 4002 (running, socket not listening)'.
	self assert: (presenter labelFor: (PharoFakeMCPServer port: 4003 running: false listening: true)) equals: 'MCP on port 4003 (stopped, socket still listening)'
]

{ #category : 'tests' }
PharoMCPServersPresenterTest >> testRefreshDisplaysTheServersOnceMCPIsLoadedAfterTheBuild [

	| lateLoaded |
	lateLoaded := PharoMCPLateLoadedPresenter new.
	lateLoaded build.
	self deny: lateLoaded layout children first identicalTo: lateLoaded serversList.
	lateLoaded loadMCPNow.
	lateLoaded refresh.
	self assert: lateLoaded layout children first identicalTo: lateLoaded serversList.
	self assert: lateLoaded serversList items size equals: 1
]
