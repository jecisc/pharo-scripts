Extension { #name : #IceGitHubNewPullRequestCommand }

{ #category : #'*PharoSettings7To8' }
IceGitHubNewPullRequestCommand class >> defaultHelp [
	^ ''
]

{ #category : #'*PharoSettings7To8' }
IceGitHubNewPullRequestCommand class >> defaultMenuIconName [
	^ #glamorousRestart
]

{ #category : #'*PharoSettings7To8' }
IceGitHubNewPullRequestCommand class >> defaultToolbarItemName [
	^ 'PR'
]

{ #category : #'*PharoSettings7To8' }
IceGitHubNewPullRequestCommand class >> toolbarRepositoryActivation [
	<classAnnotation>
	^ IceTipToolbarActivation byRootGroupItemFor: IceTipRepositoryContext order: 5000
]

{ #category : #'*PharoSettings7To8' }
IceGitHubNewPullRequestCommand class >> toolbarWorkingCopyActivation [
	<classAnnotation>
	^ IceTipToolbarActivation byRootGroupItemFor: IceTipWorkingCopyContext order: 5000
]
