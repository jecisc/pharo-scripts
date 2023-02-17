*PharoSettings
githubUser: userName project: projectName commitish: commitish path: path
			^ self new
				githubUser: userName project: projectName commitish: commitish path: path;
				baseline: projectName;
				onWarningLog;
				load