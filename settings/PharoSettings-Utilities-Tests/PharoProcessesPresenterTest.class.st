"
I test PharoProcessesPresenter. The processes I create are terminated after each test.
"
Class {
	#name : 'PharoProcessesPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter',
		'process'
	],
	#category : 'PharoSettings-Utilities-Tests',
	#package : 'PharoSettings-Utilities-Tests'
}

{ #category : 'running' }
PharoProcessesPresenterTest >> setUp [

	super setUp.
	presenter := PharoProcessesPresenter new.
	process := [ (Delay forSeconds: 30) wait ] newProcess.
	process
		name: 'Utilities bar test process';
		priority: 30
]

{ #category : 'running' }
PharoProcessesPresenterTest >> tearDown [

	process terminate.
	presenter stopRefreshing.
	super tearDown
]

{ #category : 'tests' }
PharoProcessesPresenterTest >> testActiveProcessCannotBeTerminated [

	self deny: (presenter canTerminate: Processor activeProcess).
	self assert: (presenter canTerminate: process)
]

{ #category : 'tests' }
PharoProcessesPresenterTest >> testActiveProcessHasAGreenDot [

	self assert: (presenter dotColorFor: Processor activeProcess) equals: Color green
]

{ #category : 'tests' }
PharoProcessesPresenterTest >> testDisplayedUtilityRefreshes [

	| utility |
	utility := PharoProcessesUtility new.
	utility buildContent.
	[
		utility displayed.
		self assert: utility presenter isRefreshing ] ensure: [ utility hidden ].
	self deny: utility presenter isRefreshing
]

{ #category : 'tests' }
PharoProcessesPresenterTest >> testLabelGivesTheNamePriorityAndState [

	self assert: (presenter labelFor: process) equals: 'Utilities bar test process (priority 30, suspended)'
]

{ #category : 'tests' }
PharoProcessesPresenterTest >> testMegabytes [

	self assert: (presenter megabytes: 149405696) equals: '142.5 MB'
]

{ #category : 'tests' }
PharoProcessesPresenterTest >> testStartAndStopRefreshing [

	presenter startRefreshing.
	self assert: presenter isRefreshing.
	presenter stopRefreshing.
	self deny: presenter isRefreshing
]

{ #category : 'tests' }
PharoProcessesPresenterTest >> testSuspendedProcessHasAnOrangeDot [

	self assert: (presenter dotColorFor: process) equals: Color orange
]

{ #category : 'tests' }
PharoProcessesPresenterTest >> testTerminatedProcessesAreNotListed [

	self assert: (presenter processes includes: process).
	process terminate.
	self deny: (presenter processes includes: process)
]

{ #category : 'tests' }
PharoProcessesPresenterTest >> testWaitingProcessHasAGrayDot [

	process priority: Processor activePriority + 1.
	process resume.
	self assert: (presenter dotColorFor: process) equals: Color gray.
	self assert: (presenter labelFor: process) equals: ('Utilities bar test process (priority {1}, waiting)' format: { process priority })
]
