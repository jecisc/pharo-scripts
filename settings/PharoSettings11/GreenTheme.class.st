"
A green theme.
"
Class {
	#name : 'GreenTheme',
	#superclass : 'ColoredBasedTheme',
	#category : 'PharoSettings11',
	#package : 'PharoSettings11'
}

{ #category : 'query' }
GreenTheme class >> beCurrent [
	<script>
	super beCurrent
]

{ #category : 'configuration' }
GreenTheme class >> colorConfiguratorClass [

	^ GreenThemeConfigurator
]

{ #category : 'accessing' }
GreenTheme class >> themeName [
	^ 'Green Theme'
]

{ #category : 'basic-colors' }
GreenTheme >> progressBarProgressFillStyleFor: aProgressBar [
	^ Color fromHexString: '4CAF50'
]
