initialization
setFonts
	<script>
	| provider |
	provider := FreeTypeFontProvider current.

	((provider platformAbsoluteDirectories flatCollect: #files) select: [ :e | e basenameWithoutExtension beginsWith: 'Roboto' ])
		ifEmpty: [ self inform: 'Roboto is not installed' ]
		ifNotEmpty: [ :fonts | 
			fonts do: [ :file | provider updateFromFile: file ].
			provider updateAvailableFontFamilies.
			StandardFonts defaultFont: (LogicalFont familyName: 'Roboto' pointSize: 10).
			GraphicFontSettings resetAllFontToDefaultButton ]