Extension { #name : #IceGitHubNewPullRequestCommand }

{ #category : #'*PharoSettingsUpTo8' }
IceGitHubNewPullRequestCommand class >> defaultHelp [
	^ ''
]

{ #category : #'*PharoSettingsUpTo8' }
IceGitHubNewPullRequestCommand class >> defaultMenuIconName [
	^ #glamorousRestart
]

{ #category : #'*PharoSettingsUpTo8' }
IceGitHubNewPullRequestCommand class >> defaultToolbarItemName [
	^ 'PR'
]

{ #category : #'*PharoSettingsUpTo8' }
IceGitHubNewPullRequestCommand class >> toolbarRepositoryActivation [
	<classAnnotation>
	^ IceTipToolbarActivation byRootGroupItemFor: IceTipRepositoryContext order: 5000
]

{ #category : #'*PharoSettingsUpTo8' }
IceGitHubNewPullRequestCommand class >> toolbarWorkingCopyActivation [
	<classAnnotation>
	^ IceTipToolbarActivation byRootGroupItemFor: IceTipWorkingCopyContext order: 5000
]
