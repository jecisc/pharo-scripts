*PharoSettings6
cyrilMenuOn: aBuilder
	"I add my own paste to escape strings"

	<contextMenu>
	<RubSmalltalkCodeMenu>
	(aBuilder item: #PasteWithStringEscape translated)
		keyText: 'u';
		selector: #pasteWithStringEscape;
		help: nil;
		iconName: #smallPasteIcon