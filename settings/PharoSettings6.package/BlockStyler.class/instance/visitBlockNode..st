visiting
visitBlockNode: aBlockNode
	(SHPreferences enabled and: self class enabled) ifTrue: [ (self backgroundLineLimits: (self lineLimitsOf: aBlockNode)) do: [ :line | | change |
		change := RubConfigurationChange new.
		change configurationBlock: [ :t | | r |
			r := RubTextSegmentMorph from: aBlockNode left + line key - 1 to: aBlockNode left + line value.
			r color: backgroundColor.
			t addSegment: r ].
		textModel announce: change ] ].
	nesting := nesting + 1.
	super visitBlockNode: aBlockNode.
	nesting := nesting - 1.