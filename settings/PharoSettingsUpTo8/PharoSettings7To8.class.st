Class {
	#name : #PharoSettings7To8,
	#superclass : #PharoAbstractSettings,
	#category : #PharoSettingsUpTo8
}

{ #category : #initialization }
PharoSettings7To8 class >> icebergHack [
	"I want the Branch option of Iceberg to be here even in Detached Head or even if the source directory is missing."

	<script>
	(IceTipCheckoutBranchCommand class >> #canBeExecutedInContext:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altCanBeExecutedInContext:;
				arguments: #(#arguments);
				control: #instead)
]

{ #category : #initialization }
PharoSettings7To8 class >> initialize [
	self 
		icebergHack;
		showProtocolsInSenderImplementors
]

{ #category : #initialization }
PharoSettings7To8 class >> showProtocolsInSenderImplementors [

	<script>
	(ClyQueryBrowser >> #initializeNavigationViews) ast link: (MetaLink new
			 metaObject: #receiver;
			 selector: #altInitializeNavigationViews;
			 control: #instead)
]

{ #category : #'see class side' }
PharoSettings7To8 >> seeClassSide [
]
