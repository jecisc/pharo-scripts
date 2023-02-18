class refactoring
cleanProjectWithChanel

	<script>
	self open: 'sourcesDir := PharoQuickAccess sharedRepositoryFolder / ''jecisc'' / ''Chanel'' / ''src''.
sourcesDir exists
	ifTrue: [ Metacello new
			repository: ''tonel://'' , sourcesDir fullName;
			baseline: ''Chanel'';
			load ]
	ifFalse: [ (UIManager default questionWithoutCancel: ''Clone Chanel?'')
			ifTrue: [ Metacello new
					githubUser: ''jecisc'' project: ''Chanel'' commitish: ''master'' path: ''repository'';
					baseline: ''Chanel'';
					load ] ].

packages := ((IceRepository registry select: [ :e | e name = ''Moose'' ]) flatCollect: [ :e | e workingCopy packageNames collect: [:s | s asPackageIfAbsent: [ nil ] ]]) reject: #isNil..

Chanel perfum: packages'