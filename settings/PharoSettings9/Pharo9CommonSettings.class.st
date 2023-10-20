"
Settings for Pharo 9+
"
Class {
	#name : 'Pharo9CommonSettings',
	#superclass : 'PharoAbstractSettings',
	#category : 'PharoSettings9',
	#package : 'PharoSettings9'
}

{ #category : 'class initialization' }
Pharo9CommonSettings class >> calypsoOptions [
	<script>
	ClyTextLineNumbersSwitchMorph showLineNumbers: true
]

{ #category : 'initialization' }
Pharo9CommonSettings class >> disableSomeGTSpotterExtensions [
	"World menu because it is too long with my scripts."

	<script>
	StWorldMenuProcessor enabled: false
]

{ #category : 'initialization' }
Pharo9CommonSettings class >> enableFluidClassDefinition [
	<script>
	SystemVersion current major < 12 ifTrue:[ClassDefinitionPrinter showFluidClassDefinition: true]
]

{ #category : 'initialization' }
Pharo9CommonSettings class >> formatingOptions [

	<script>
	EFFormatter
		multiLineMessages:
			'#(#on:do: #ensure: #ifCurtailed: #ifTrue:ifFalse: #ifFalse:ifTrue: #ifEmtpy:ifNotEmpty: #ifNotEmpty:ifEmpty: #ifExists:ifAbsent: #ifNil:ifNotNil: #ifNotNil:ifNil: #detect:ifFound: #detect:ifNone: #detect:ifFound:ifNone: #at:ifPresent:ifAbsent: #collect:thenDo: #collect:thenReject: #collect:thenSelect:  #reject:thenCollect: #reject:thenDo: #select:thenCollect: #select:thenDo:)';
		retainBlankLinesBetweenStatements: true;
		maxLineLength: 160;
		numberOfNewLinesAfterMethodSignature: 2
]

{ #category : 'class initialization' }
Pharo9CommonSettings class >> initialize [
	self
		disableSomeGTSpotterExtensions;
		formatingOptions;
		setPlaygroundFolder;
		setMetaLinkForIcebergBrowseInGroupCommand;
		enableFluidClassDefinition;
		calypsoOptions
]

{ #category : 'class initialization' }
Pharo9CommonSettings class >> setMetaLinkForBlockStyler [

	<script>
	(ClyMethodEditorToolMorph >> #textChanged:) ast link: (MetaLink new
			 metaObject: #receiver;
			 selector: #myTextChanged:;
			 arguments: #( #arguments );
			 control: #instead)
]

{ #category : 'class initialization' }
Pharo9CommonSettings class >> setMetaLinkForIcebergBrowseInGroupCommand [

	<script>
	(IceTipRepositoriesBrowser class>> #buildSelectionCommandGroupWith:for:) ast link: (MetaLink new
			 metaObject: #receiver;
			 selector: #altBuildSelectionCommandGroupWith:;
			 arguments: #( #arguments );
			 control: #instead)
]

{ #category : 'class initialization' }
Pharo9CommonSettings class >> setPlaygroundFolder [
	<script>
	StPlayground cacheDirectory: self rootFolder / 'play-cache'
]

{ #category : 'see class side' }
Pharo9CommonSettings >> seeClassSide [
]
