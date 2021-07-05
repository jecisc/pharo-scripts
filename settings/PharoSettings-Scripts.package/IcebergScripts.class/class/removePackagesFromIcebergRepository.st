removing
removePackagesFromIcebergRepository
	<script>
	self open: '(IceRepository registry detect: [ :e | e name = ''MyProject'' ]) workingCopy packages
		select: [ :p | p name includesSubstring: ''SubString'' ]
		thenDo: #remove'