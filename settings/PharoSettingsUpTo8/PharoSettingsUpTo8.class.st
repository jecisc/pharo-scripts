Class {
	#name : #PharoSettingsUpTo8,
	#superclass : #PharoAbstractSettings,
	#category : 'PharoSettingsUpTo8'
}

{ #category : #initialization }
PharoSettingsUpTo8 class >> addMetaLinksForDebugger [
	<script>
	(GTRunToSelectionDebugAction >> #defaultOrder) ast
		link:
			(MetaLink new
				metaObject: [ 100 ];
				control: #instead).
	(GTGenericStackDebugger >> #codeActionsPragmas) ast
		link:
			(MetaLink new
				metaObject: [ #(customDebuggingAction codeDebuggingAction) ];
				control: #instead)
]

{ #category : #'class initialization' }
PharoSettingsUpTo8 class >> addMetalinkToCmdClickOnSymbols [
	<script>
	self flag: #pharo7.
	(SHRBTextStyler >> ((SHRBTextStyler isLocalSelector: #visitLiteralNode:) ifTrue: [ #visitLiteralNode: ] ifFalse: [ #visitLiteralValueNode: ])) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altVisitLiteralValueNode:;
				arguments: #(#arguments);
				control: #instead)
]

{ #category : #'class initialization' }
PharoSettingsUpTo8 class >> disableSomeGTSpotterExtensions [
	"World menu because it is too long with my scripts."

	<script>
	#('GTSpotter_spotterWorldMenuFor') do: [ :ext | GTSpotterExtensionSettings disabledExtensions add: ext ]
]

{ #category : #initialization }
PharoSettingsUpTo8 class >> enableGTSpotterPreview [
	<script>
	GTSpotter showPreview
]

{ #category : #initialization }
PharoSettingsUpTo8 class >> enableSlotClassDefinition [
	"Slot class definition is replaced by fluid class definition in P9"

	<script>
	Slot showSlotClassDefinition: true
]

{ #category : #initialization }
PharoSettingsUpTo8 class >> formatingOptions [
	<script>
	BIConfigurableFormatter
		multiLineMessages:
			'#(#on:do: #ensure: #ifCurtailed: #ifTrue:ifFalse: #ifFalse:ifTrue: #ifEmtpy:ifNotEmpty: #ifNotEmpty:ifEmpty: #ifExists:ifAbsent: #ifNil:ifNotNil: #ifNotNil:ifNil: #detect:ifFound: #detect:ifNone: #detect:ifFound:ifNone: #at:ifPresent:ifAbsent: #collect:thenDo: #collect:thenReject: #collect:thenSelect:  #reject:thenCollect: #reject:thenDo: #select:thenCollect: #select:thenDo:)';
		retainBlankLinesBetweenStatements: true;
		maxLineLength: 160.
	(BIConfigurableFormatter >> #formatArray:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #myFormatArray:;
				arguments: #(#arguments);
				control: #instead)
]

{ #category : #'class initialization' }
PharoSettingsUpTo8 class >> initialize [
	self
		addMetalinkToCmdClickOnSymbols;
		addMetaLinksForDebugger;
		disableSomeGTSpotterExtensions;
		formatingOptions;
		enableSlotClassDefinition;
		enableGTSpotterPreview;
		setLocalFolders
]

{ #category : #initialization }
PharoSettingsUpTo8 class >> setLocalFolders [
	<script>
	GTPlayBook cacheDirectory: self rootFolder / 'play-cache'.
	GTPlayBook stashDirectory: self rootFolder / 'play-stash'
]

{ #category : #'see class side' }
PharoSettingsUpTo8 >> seeClassSide [
]
