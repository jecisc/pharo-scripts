*PharoSettings
stHubUser: userName project: projectName
			^ self new 
				smalltalkhubUser: userName project: projectName;
				configuration: projectName;
				onWarningLog;
				load