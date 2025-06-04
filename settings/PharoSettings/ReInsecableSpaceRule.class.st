"
A rule to highlight insecable spaces.
"
Class {
	#name : 'ReInsecableSpaceRule',
	#superclass : 'ReAbstractRule',
	#category : 'PharoSettings',
	#package : 'PharoSettings'
}

{ #category : 'testing-interest' }
ReInsecableSpaceRule class >> checksMethod [
	^ true
]

{ #category : 'accessing' }
ReInsecableSpaceRule class >> group [
	^ 'Bugs'
]

{ #category : 'class initialization' }
ReInsecableSpaceRule class >> initialize [
	ReRuleManager resetWithInform
]

{ #category : 'accessing' }
ReInsecableSpaceRule class >> rationale [
	^ 'Insecable spaces might break a lot of code and is usually unitentional.'
]

{ #category : 'accessing' }
ReInsecableSpaceRule class >> ruleName [
	^ 'There is an insequable space that might break the method.'
]

{ #category : 'accessing' }
ReInsecableSpaceRule class >> severity [
	^ #error
]

{ #category : 'helpers' }
ReInsecableSpaceRule >> anchorFor: anEntity [
	^ ReSearchStringSourceAnchor entity: anEntity string: Character nbsp asString
]

{ #category : 'running' }
ReInsecableSpaceRule >> basicCheck: aMethod [
	^ aMethod sourceCode includes: Character nbsp
]

{ #category : 'accessing' }
ReInsecableSpaceRule >> group [

	^ self class group
]

{ #category : 'accessing' }
ReInsecableSpaceRule >> name [

	^ self class ruleName
]

{ #category : 'accessing' }
ReInsecableSpaceRule >> rationale [

	^ self class rationale
]

{ #category : 'accessing' }
ReInsecableSpaceRule >> severity [

	^ self class severity
]
