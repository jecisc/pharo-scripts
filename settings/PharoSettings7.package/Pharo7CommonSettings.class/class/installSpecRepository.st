initialization
installSpecRepository
	<script>
	(self imageNameBeginsWith: 'Spec-') ifFalse: [ ^ self ].

	self registerIfPresentProjectOf: 'pharo-spec' named: 'Spec'.
	Deprecation raiseWarning: false