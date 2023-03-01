Extension { #name : #Metacello }

{ #category : #'*PharoSettings' }
Metacello >> githubBaseline: userName project: projectName commitish: commitish path: path [
			self githubUser: userName project: projectName commitish: commitish path: path.
			self baseline: projectName
]

{ #category : #'*PharoSettings' }
Metacello class >> githubUser: userName project: projectName commitish: commitish path: path [
			^ self new
				githubUser: userName project: projectName commitish: commitish path: path;
				baseline: projectName;
				onWarningLog;
				load
]

{ #category : #'*PharoSettings' }
Metacello >> stHubConf: userName project: projectName [
			self smalltalkhubUser: userName project: projectName.
			self configuration: projectName
]

{ #category : #'*PharoSettings' }
Metacello class >> stHubUser: userName project: projectName [
			^ self new
				smalltalkhubUser: userName project: projectName;
				configuration: projectName;
				onWarningLog;
				load
]
