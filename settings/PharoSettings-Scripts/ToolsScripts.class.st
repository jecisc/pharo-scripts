"
Scripts about tooling

"
Class {
	#name : 'ToolsScripts',
	#superclass : 'Scripts',
	#category : 'PharoSettings-Scripts',
	#package : 'PharoSettings-Scripts'
}

{ #category : 'actions' }
ToolsScripts class >> useCalypsoMethodBrowser [

	<script>
	ClyOldMessageBrowserAdapter beDefaultBrowser
]

{ #category : 'actions' }
ToolsScripts class >> useNewToolsMethodBrowser [

	<script>
	StMethodBrowser beDefaultBrowser
]

{ #category : 'see class side' }
ToolsScripts >> seeClassSide [ 
]
