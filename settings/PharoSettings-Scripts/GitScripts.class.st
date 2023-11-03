"
A bunch on scripts about git.
"
Class {
	#name : 'GitScripts',
	#superclass : 'Scripts',
	#category : 'PharoSettings-Scripts',
	#package : 'PharoSettings-Scripts'
}

{ #category : 'removing' }
GitScripts class >> createDraftOfChangelog [

	<script>
	self open: '"Create first draft of changelog:"

	''
	
git log --pretty="* %s ([%h](https://github.com/pharo-spec/Spec/commit/%H))" 8208767590371c5ce4e6938f0f79d6cea601fca8...HEAD --grep="Merge "

''.

	(''Content'' copyWithRegex: ''Merge pull request #[0-9]+ from [^/]+/[0-9]*'' matchesReplacedWith: '' '') copyReplaceAll: ''-'' with: '' ''.
	'
]

{ #category : 'removing' }
GitScripts class >> moveToTonelV3 [

	<script>
	self open: 'repository := IceRepository repositories detect: [ :repo | repo name = ''Spec2'' ].
repository workingCopy packages do: [ :pkg |
IceLibgitTonelWriter forInternalStoreFileOut: pkg latestVersion mcVersion on: repository ]'
]

{ #category : 'removing' }
GitScripts class >> removeMergedBranches [

	<script>
	self open: '"Remove merged branches except master and dev:"

''

git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d

'''
]
