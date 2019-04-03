terminal commands
coolCommands
	<name: #'Git commands'>

	GTPlayground
		openContents:
			'''Remove merged branches except master and dev:''.

	''git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d''.

''Create first draft of changelog:''.

	''git log --pretty="* %s ([%h](https://github.com/pharo-spec/Spec/commit/%H))" 8208767590371c5ce4e6938f0f79d6cea601fca8...HEAD --grep="Merge "''.'