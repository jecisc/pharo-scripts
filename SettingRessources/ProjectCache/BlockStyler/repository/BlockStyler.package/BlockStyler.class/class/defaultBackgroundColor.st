defaults
defaultBackgroundColor
	^ self defaultThemes at: Smalltalk ui theme class ifPresent: [ :each | each ] ifAbsent: [ Smalltalk ui theme backgroundColor negated alpha: 0.15 ]