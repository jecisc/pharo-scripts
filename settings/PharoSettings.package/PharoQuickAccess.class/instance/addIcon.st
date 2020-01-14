templates
addIcon
	<name: #'Add icon'>
	GTPlayground
		openContents:
			'iconName := ''myLogo''.
icon := ''/Users/cyrilferlicot/Google Drive/Personnel/Furry/IMG_3509.JPG'' asFileReference.

ThemeIcons compile:  iconName , ''Contents
	^ '''''' , (Base64MimeConverter mimeEncode: icon binaryReadStream) contents , '''''''' classified: ''*Material-Design-Lite-Core''.
	
ThemeIcons compile: iconName, ''
	^ icons
			at: #'''''' , iconName , ''''''
			ifAbsentPut:[ Form fromBinaryStream: self '' , iconName , ''Contents base64Decoded asByteArray readStream ]'' classified: ''*Material-Design-Lite-Core''.

Smalltalk ui icons perform: iconName asSymbol'