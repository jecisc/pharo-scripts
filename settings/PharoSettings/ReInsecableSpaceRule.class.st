Class {
	#name : #ReInsecableSpaceRule,
	#superclass : #ReAbstractRule,
	#category : #PharoSettings
}

{ #category : #'testing-interest' }
ReInsecableSpaceRule class >> checksMethod [
	^ true
]

{ #category : #initialization }
ReInsecableSpaceRule class >> initialize [
	ReRuleManager resetWithInform
]

{ #category : #helpers }
ReInsecableSpaceRule >> anchorFor: anEntity [
	^ ReSearchStringSourceAnchor entity: anEntity string: Character nbsp asString
]

{ #category : #running }
ReInsecableSpaceRule >> basicCheck: aMethod [
	^ aMethod sourceCode includes: Character nbsp
]

{ #category : #accessing }
ReInsecableSpaceRule >> group [
	^ 'Bugs'
]

{ #category : #accessing }
ReInsecableSpaceRule >> name [
	^ 'There is an insequable space that might break the method.'
]

{ #category : #accessing }
ReInsecableSpaceRule >> rationale [
	^ 'Insecable spaces might break a lot of code and is usually unitentional.'
]

{ #category : #accessing }
ReInsecableSpaceRule >> severity [
	^ #error
]
