Class {
	#name : #BaselineOfNativeBrowser,
	#superclass : #BaselineOf,
	#category : #BaselineOfNativeBrowser
}

{ #category : #baselines }
BaselineOfNativeBrowser >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: 'Native-Browser' ]
]

{ #category : #accessing }
BaselineOfNativeBrowser >> projectClass [
	^ [ self class environment at: #MetacelloCypressBaselineProject ]
		on: NotFound
		do: [ super projectClass ]
]
