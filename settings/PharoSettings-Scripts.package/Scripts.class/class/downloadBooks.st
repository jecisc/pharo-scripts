as yet unclassified
downloadBooks
	<script>
	self open: '| folder novelFolder page urls |
	folder := (FileLocator documents / ''Novels'') ensureCreateDirectory.
	#(''a-will-eternal'' ''i-shall-seal-the-heavens'' ''stellar-transformations'' ''warlock-of-the-magus-world'' ''battle-through-the-heavens'' ''desolate-era'' ''i-reincarnated-for-nothing'' ''legend-of-the-dragon-king'' ''renegade-immortal'' ''sage-monarch'' ''tales-of-demons-and-gods'' ''the-unrivaled-tang-sect'')
		do: [ :novel |
			novelFolder := folder / novel.
			novelFolder ensureCreateDirectory.

			page := XMLHTMLParser parseURL: ''https://www.wuxiaworld.com/novel/'' , novel.

			urls := (page xpath: ''''//li[@class=''chapter-item'''']/a/@href'') stringValues collect: [ :e | ''https://www.wuxiaworld.com'' , e ].

			urls
				do: [ :url |
					ZnClient new
						url: url;
						downloadTo: novelFolder / ((url copyAfterLast: $/) , ''.html'') ]
				displayingProgress: [ :u | u ] ]
		displayingProgress: [ :novel | novel ]'