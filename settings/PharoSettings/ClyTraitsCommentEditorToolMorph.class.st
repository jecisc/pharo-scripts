"
A tab of Calypso to display the comments of used traits.
"
Class {
	#name : 'ClyTraitsCommentEditorToolMorph',
	#superclass : 'ClyClassEditorToolMorph',
	#category : 'PharoSettings',
	#package : 'PharoSettings'
}

{ #category : 'testing' }
ClyTraitsCommentEditorToolMorph class >> shouldBeActivatedInContext: aToolContext [
	(super shouldBeActivatedInContext: aToolContext) ifFalse: [ ^ false ].

	^ aToolContext isSelectedClassUsesTraits
]

{ #category : 'accessing' }
ClyTraitsCommentEditorToolMorph class >> tabOrder [
	^ super tabOrder - 0.5
]

{ #category : 'activation' }
ClyTraitsCommentEditorToolMorph class >> traitsCommentTabActivation [

	<classAnnotation>
	^ (SystemVersion current major < 11
		   ifTrue: [ ClyTabActivationStrategy ]
		   ifFalse: [ ClyTabActivationStrategyAnnotation ]) for: ClyClassComment asCalypsoItemContext
]

{ #category : 'operations' }
ClyTraitsCommentEditorToolMorph >> applyChanges [
	^ false
]

{ #category : 'building' }
ClyTraitsCommentEditorToolMorph >> buildTextMorph [
	super buildTextMorph.
	textMorph beReadOnly
]

{ #category : 'initialization' }
ClyTraitsCommentEditorToolMorph >> defaultIconName [
	^ (editingClass traitComposition allTraits anySatisfy: #hasComment)
		ifTrue: [ #comments ]
		ifFalse: [ #uncommentedClass ]
]

{ #category : 'initialization' }
ClyTraitsCommentEditorToolMorph >> defaultTitle [
	^ 'Traits Comments'
]

{ #category : 'accessing' }
ClyTraitsCommentEditorToolMorph >> editingText [
	^ String
		streamContents: [ :s |
			editingClass traitComposition allTraits
				do: [ :trait |
					trait hasComment
						ifTrue: [ s
								nextPutAll: '=== ';
								nextPutAll: trait name;
								nextPutAll: '===';
								lf;
								lf;
								nextPutAll: trait comment;
								lf;
								lf ] ] ]
]

{ #category : 'printing' }
ClyTraitsCommentEditorToolMorph >> printContext [
	^ super printContext , ' / ' , editingClass name
]

{ #category : 'initialization' }
ClyTraitsCommentEditorToolMorph >> setUpDefaultIcon [
	"Here we duplicate logic of #defaultIconName to directly ask class about comment.
	This method is called during background tab building.
	So it does not really affect performance which is critical for remote scenario"

	| iconName |
	iconName := (editingClass traitComposition allTraits anySatisfy: #hasComment)
		ifTrue: [ #comments ]
		ifFalse: [ #uncommentedClass ].
	containerTab icon: (self iconNamed: iconName)
]

{ #category : 'testing' }
ClyTraitsCommentEditorToolMorph >> wantsTextStyling [
	^false
]
