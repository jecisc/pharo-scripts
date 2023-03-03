Class {
	#name : #PharoSettings11,
	#superclass : #PharoAbstractSettings,
	#category : #PharoSettings11
}

{ #category : #initialization }
PharoSettings11 class >> debuggerCustomizations [

	<script>
	StDebuggerActionModel shouldFilterStack: false
]

{ #category : #initialization }
PharoSettings11 class >> initialize [

	self
		spotterCustomizations;
		debuggerCustomizations
]

{ #category : #initialization }
PharoSettings11 class >> spotterCustomizations [
	<script>

	StSpotter insertsSelection: false
]

{ #category : #'see class side' }
PharoSettings11 >> seeClassSide [
]
