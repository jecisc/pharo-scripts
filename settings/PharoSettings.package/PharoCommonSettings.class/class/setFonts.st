initialization
setFonts
	<script>
	FreeTypeFontProvider current updateFromSystem.
	LogicalFontManager current allFamilies
		detect: [ :e | e familyName = 'Roboto' ]
		ifFound: [ :f | 
			StandardFonts defaultFont: (LogicalFont familyName: 'Roboto' pointSize: 10).

			GraphicFontSettings resetAllFontToDefaultButton ]
		ifNone: [ self inform: 'Roboto is not installed' ]