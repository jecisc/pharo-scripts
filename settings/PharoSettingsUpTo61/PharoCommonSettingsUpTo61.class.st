Class {
	#name : #PharoCommonSettingsUpTo61,
	#superclass : #PharoAbstractSettings,
	#category : 'PharoSettingsUpTo61'
}

{ #category : #adding }
PharoCommonSettingsUpTo61 class >> addMetaLinkForKomitter [
	<script>
	(KomitStagingArea >> #remotes) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #remotesAlt;
				control: #instead)
]

{ #category : #initialization }
PharoCommonSettingsUpTo61 class >> codeCompletionPreferences [
	<script>
	NECPreferences overrideModel: true
]

{ #category : #initialization }
PharoCommonSettingsUpTo61 class >> initialize [
	self 
		addMetaLinkForKomitter;
		codeCompletionPreferences
]
