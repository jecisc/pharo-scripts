initialization
someToolsOptions
	<script>
	Slot showSlotClassDefinition: true.
	MCWorkingCopyBrowser order: 4.
	MCRepositoryGroup default repositories
		select: [ :r | r location includesSubstring: 'Pharo/Pharo' ]
		thenDo: [ :r | MCRepositoryGroup default removeRepository: r ]