CodeCleaner cleanPackages: (RPackageOrganizer includingSubstring: 'MDL').


I am in charge of cleaning multiple things in packages of a project. 

1) Tests equality
================================

A first thing I'll clean is equality. For example I'll replace those cases:


x assert: y = z 					==> x assert: y equals: z

x deny: y = z 						==> x deny: y equals: z

x assert: y == z 					==> x assert: y identicalTo: z

x deny: y == z 						==> x deny: y identicalTo: z

x assert: y = true 				==> x assert: y

x deny y = true 					==> x deny: y

x assert: y = false 				==> x deny: y

x deny: y = false 					==> x assert: y

x assert: y equals: true 		==> x assert: y

x deny y equals: true 			==> x deny: y

x assert: y equals: false 		==> x deny: y

x deny: y equals: false 			==> x assert: y

2) Clean protocols
================================

I do multiple cleanings in protocols. 

* I'll ensure that some methods are in the right protocol. For example #initialize should be in #initialization. Find more in `self methodsInSpecificProtocolMap` and `self testMethodsInSpecificProtocolMap`.
* I'll update some protocols to follow convensions. For example I'll update initialize-release to initialize. Find more in `self protocolsToCleanMap`.

3) Conditional simplifications
================================

I simplify conditionals. For example I'll rewrite:

x isNil ifTrue: y 							==> x ifNil: y

x isNil ifFalse: y 						==> x ifNotNil: y

x isNotNil ifTrue: y 						==> x ifNotNil: y

x isNotNil ifFalse: y 					==> x ifNil: y

x isNil ifTrue: y ifFalse: z 			==> x ifNil: y ifNotNil: z

x isNil ifFalse: y ifTrue: z 			==> x ifNil: z ifNotNil: y

x isNotNil ifTrue: y ifFalse: z 		==> x ifNil: z ifNotNil: y

x isNotNil ifFalse: y ifTrue: z 		==> x ifNil: y ifNotNil: z

4) Test case names
================================

Will rename each test case ending with "Tests" te end with "Test" since this is "a XXTestCase".

5) Ensure right super are call
================================

- Ensure #setUp in TestCases always begins by `super setUp` (move it if not the first messand sent)
- Ensure #tearDown in TestCases always ends by `super tearDown` (move it if not the last messand sent)
- Ensure #initialize on instance side always has `super initialize`

6) Remove nil assignments in initialization
================================

Will remove all nil assignations in initialize methods because most of the time they are not needed. Be careful, in some cases, they are. 