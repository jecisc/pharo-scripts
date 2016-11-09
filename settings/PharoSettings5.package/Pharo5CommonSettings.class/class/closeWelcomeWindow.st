initialization
closeWelcomeWindow
	<script>
	World submorphs select: [ :m | m isSystemWindow and: [ m label = PharoWelcomePage title ] ] thenDo: #delete