initialization
installGitFileTree
	<script>
	Metacello new
		baseline: 'FileTree';
		repository: 'github://dalehenrich/filetree:pharo' , SystemVersion current dottedMajorMinor , '_dev/repository';
		load: 'Git'