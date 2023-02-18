removing
removeMergedBranches

	<script>
	self open: '"Remove merged branches except master and dev:"

''

git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d

'''