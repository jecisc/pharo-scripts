"
A bunch on scripts about benchmarking.
"
Class {
	#name : 'BenchmarkScripts',
	#superclass : 'Scripts',
	#category : 'PharoSettings-Scripts',
	#package : 'PharoSettings-Scripts'
}

{ #category : 'benchmarking' }
BenchmarkScripts class >> benchTestSuite [
	<script>
	self open: '| packageSelectionBlock testSuite |
	packageSelectionBlock := [ :e | e name beginsWith: ''IngeProj'' ].
	testSuite := TestSuite new.

	((self packageOrganizer packages select: packageSelectionBlock) flatCollect: #classes)
		select: [ :e | e inheritsFrom: TestCase ]
		thenDo: [ :e | e addToSuiteFromSelectors: testSuite ].

	[ testSuite run ] spy'
]

{ #category : 'see class side' }
BenchmarkScripts >> seeClassSide [
]
