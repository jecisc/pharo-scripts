"
A bunch on scripts Telescope
"
Class {
	#name : 'TelescopeScripts',
	#superclass : 'Scripts',
	#category : 'PharoSettings-Scripts',
	#package : 'PharoSettings-Scripts'
}

{ #category : 'accessing' }
TelescopeScripts class >> dependenciesOfAProject [
	<script>
	self open: '| baseline visu substringsToHighlight |
	baseline := self class environment at: #BaselineOfTelescope.
	substringsToHighlight := #(#Telescope #Cytoscape).
	visu := TLVisualization new.
	visu
		addNodesFromEntities:
			((baseline project version withDeepCollect: [ :each | each projects collect: #version ])
				inject: OrderedCollection new
				into: [ :coll :vers |
					coll
						detect: [ :each | each versionNumber = vers versionNumber and: [ each projectLabel = vers projectLabel ] ]
						ifNone: [ coll add: vers ].
					coll ]).

	visu nodes
		do: [ :each |
			(each entity projects
				collect: [ :e |
					visu nodes
						detect: [ :n | n entity = e version and: [ n entity projectLabel = e version projectLabel ] ]
						ifNone: [ nil ] ]) asSet do: [ :n | n ifNotNil: [ each connectToNode: n ] ] ].

	visu styleSheet
		nodeLabel: [ :each | each projectLabel withoutPrefix: #BaselineOf ];
		nodeLabelPosition: #bottom;
		backgroundColor: [ :each |
			(substringsToHighlight anySatisfy: [ :e | each projectLabel includesSubstring: e ])
				ifTrue: [ MDLColor green ]
				ifFalse: [ MDLColor orange ] ];
		labelSize: 11.

	visu
		layout:
			(TLTreeLayout rightToLeft
				leavesGap: 100;
				levelGap: 100;
				yourself).

	visu
		addInteractions:
			{(TLStyleCustomizationAction
				custom: [ :style :drawable |
					drawable isConnection
						ifTrue: [ style
								color: MDLColor blue;
								width: 3 ]
						ifFalse: [ style
								labelSize: 20;
								textColor: MDLColor blue ].
					self ]
				target: [ :aDrawable | aDrawable incomingConnections flatCollectAsSet: #withConnectedNodes ]) onMouseOver propagateToChildren.
			(TLStyleCustomizationAction
				custom: [ :style :drawable |
					drawable isConnection
						ifTrue: [ style
								color: MDLColor orange;
								width: 3 ]
						ifFalse: [ style
								labelSize: 20;
								textColor: MDLColor orange ].
					self ]
				target: [ :aDrawable | aDrawable outgoingConnections flatCollectAsSet: #withConnectedNodes ]) onMouseOver propagateToChildren}.

	visu open'
]

{ #category : 'see class side' }
TelescopeScripts >> seeClassSide [
]
