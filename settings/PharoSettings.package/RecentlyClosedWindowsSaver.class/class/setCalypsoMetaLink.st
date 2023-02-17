class initialization
setCalypsoMetaLink
	"When a Calypso window is closing, it is removing its content making it impossible to open again the window.
	To work around the problem I use a metalink to not remove the content."

	<script>
	self environment
		at: #ClyBrowserMorph
		ifPresent: [ :class |
			(class >> #windowIsClosing) sourceCode
				=
					'windowIsClosing

	navigationViews do: [ :each | each windowIsClosing ].
	tabManager windowIsClosing.
	self window ifNotNil: [ :w |
		w
			removeMorph: self;
			updatePanesFromSubmorphs;
			model: nil]'
				ifTrue: [ class
						compiledMethodAt: #altWindowIsClosing
						ifAbsent: [ class
								compile:
									'altWindowIsClosing
	navigationViews do: [ :each | each windowIsClosing ].
	tabManager windowIsClosing'
								classified: '*' , self package name ].


					(class >> #windowIsClosing) ast
						link:
							(MetaLink new
								metaObject: #receiver;
								selector: #altWindowIsClosing;
								control: #instead) ] ]