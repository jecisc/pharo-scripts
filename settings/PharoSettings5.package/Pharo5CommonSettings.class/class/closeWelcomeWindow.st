initialization
closeWelcomeWindow
	<script>
	World submorphs select: [ :m | m isSystemWindow and: [ m label includesSubstring: 'Welcome' ] ] thenDo: #delete