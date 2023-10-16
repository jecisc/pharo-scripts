"
A bunch on scripts Iceberg
"
Class {
	#name : 'IcebergScripts',
	#superclass : 'Scripts',
	#category : 'PharoSettings-Scripts',
	#package : 'PharoSettings-Scripts'
}

{ #category : 'removing' }
IcebergScripts class >> removePackagesFromIcebergRepository [
	<script>
	self open: '(IceRepository registry detect: [ :e | e name = ''MyProject'' ]) workingCopy packages
		select: [ :p | p name includesSubstring: ''SubString'' ]
		thenDo: #remove'
]

{ #category : 'see class side' }
IcebergScripts >> seeClassSide [
]
