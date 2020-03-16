initialization
setFonts
	<script>
	| provider |
	provider := FreeTypeFontProvider current.

	(provider platformAbsoluteDirectories flatCollect: #files)
		detect: [ :e | e basenameWithoutExtension = 'Roboto-Medium' ]
		ifFound: [ :file | 
			provider updateFromFile: file.
			StandardFonts defaultFont: (LogicalFont familyName: 'Roboto' pointSize: 10).
			GraphicFontSettings resetAllFontToDefaultButton ]
		ifNone: [ self inform: 'Roboto is not installed' ]