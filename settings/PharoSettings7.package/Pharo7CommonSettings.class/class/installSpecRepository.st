initialization
installSpecRepository
	<script>
	(self imageNameBeginsWithAny: #('Spec-' 'NewTools-' 'MooseSpec-')) ifFalse: [ ^ self ].

	self registerIfPresentProjectOf: 'pharo-spec' named: 'Spec'.
	Deprecation raiseWarning: false