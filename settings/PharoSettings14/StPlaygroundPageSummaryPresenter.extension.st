Extension { #name : 'StPlaygroundPageSummaryPresenter' }

{ #category : '*PharoSettings14' }
StPlaygroundPageSummaryPresenter >> altInitializePresenters [

	layout := SpBoxLayout newTopToBottom
		          borderWidth: 1;
		          spacing: 2;
		          add: (firstLineLabel := self newLabel) expand: false;
		          add: (SpBoxLayout newLeftToRight
				           spacing: 5;
				           borderWidth: 1;
				           add: (timeLabel := self newLabel);
				           add: (self newButton
						            icon: (self iconNamed: #remove);
						            help: 'This action will remove the page from the playground and remove the persisted page.';
						            action: [ self owner owner owner doRemovePage ];
						            yourself)
				           width: 25;
				           yourself);
		          yourself.

	timeLabel addStyle: 'dim'
]
