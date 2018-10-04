initialization
installNativeBrowser
	<script>
	Metacello new
		filetreeDirectory: (self projectCache / 'Native-Browser') fullName , '/src';
		baseline: 'NativeBrowser';
		load