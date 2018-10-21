initialization
installNativeBrowser
	<script>
	Metacello new
		repository: 'tonel://', (self projectCache / 'Native-Browser') fullName , '/src';
		baseline: 'NativeBrowser';
		load