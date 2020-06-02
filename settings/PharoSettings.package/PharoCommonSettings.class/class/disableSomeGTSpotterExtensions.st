initialization
disableSomeGTSpotterExtensions
	"World menu because it is too long with my scripts."

	<script>
	SystemVersion current major < 9
		ifTrue: [ #('GTSpotter_spotterWorldMenuFor') do: [ :ext | GTSpotterExtensionSettings disabledExtensions add: ext ] ]
		ifFalse: [ SptWorldMenuProcessor enabled: false ]