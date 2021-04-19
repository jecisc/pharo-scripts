initialization
someToolsOptions
	<script>
	MCWorkingCopyBrowser order: 4.
	MCRepositoryGroup default repositories
		select: [ :r | (r isKindOf: MCSmalltalkhubRepository) and: [ r location includesSubstring: 'Pharo/Pharo' ] ]
		thenDo: [ :r | MCRepositoryGroup default removeRepository: r ]