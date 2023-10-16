"
A bunch on scripts refactorings.
"
Class {
	#name : 'RefactoringScripts',
	#superclass : 'Scripts',
	#category : 'PharoSettings-Scripts',
	#package : 'PharoSettings-Scripts'
}

{ #category : 'class refactoring' }
RefactoringScripts class >> batchClassRename [
	<script>
	self open: '	classes := (RPackageOrganizer includingSubstring: ''Name'') flatCollect: #definedClasses.
oldPrefix := ''old''.
newPrefix := ''new''.

classes
	do: [ :class | (class name beginsWith: oldPrefix) ifTrue: [ (RBRenameClassRefactoring rename: class name to: newPrefix , (class name withoutPrefix: oldPrefix)) execute ] ]'
]

{ #category : 'class refactoring' }
RefactoringScripts class >> batchRenameMethodsInAClass [

	<script>
	self open: 'class := ClassOrganizationTest.
from := ''Into''.
to := ''As''.

class methods
	select: [ :method | method selector includesSubstring: from ]
	thenDo: [ :method |
		| oldSelector newSelector |
		oldSelector := method selector asSymbol.
		newSelector := (method selector copyReplaceAll: from with: to) asSymbol.

			class compiledMethodAt: newSelector ifPresent: [ :m | self inform: newSelector , '' already exists'' ] ifAbsent: [
			(RBRenameMethodRefactoring
				 renameMethod: oldSelector
				 in: class
				 to: newSelector
				 permutation: (1 to: method numArgs) asArray) execute ] ]'
]

{ #category : 'class refactoring' }
RefactoringScripts class >> batchRenameMethodsWithDeprecation [

	<script>
	self open: 'class := FM3Class.
from := ''attribute''.
to := ''propertie''.
deprecatedProtocol := ''*Famix-Deprecated''.

signatureBuilder := [ :selector |
	selector isUnary ifTrue: [ selector ] ifFalse: [
	| count |
	count := 1.
	String streamContents: [ :s | selector keywords do: [ :key | s nextPutAll: key; space; nextPutAll: ''arg''; print: count; space. count := count + 1 ] ] ] ].

class methods
	select: [ :method | method selector includesSubstring: from ]
	thenDo: [ :method |
		| oldSelector newSelector |
		oldSelector := method selector asSymbol.
		newSelector := (method selector copyReplaceAll: from with: to) asSymbol.

		class
			compiledMethodAt: newSelector
			ifPresent: [ :m | self inform: newSelector , '' already exists'' ]
			ifAbsent: [

			(RBRenameMethodRefactoring
				renameMethod: oldSelector
				in: class
				to: newSelector
				permutation: (1 to: method numArgs) asArray) execute.

			class compile: (''{1}
	{2}
	^ self {3}'' format: {signatureBuilder value: oldSelector . ''self deprecated: ''''Use #'', newSelector , '' instead.'''' transformWith: ''''``@object '' , (RBParseTreeSearcher buildSelectorString: oldSelector),'''''' -> ''''``@object '' , (RBParseTreeSearcher buildSelectorString: newSelector) ,''''''.''. signatureBuilder value: newSelector }).

			deprecatedProtocol ifNotNil: [ :p | (class>>oldSelector) protocol: p ].
			] ].'
]

{ #category : 'class refactoring' }
RefactoringScripts class >> cleanProjectWithChanel [

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
]

{ #category : 'class refactoring' }
RefactoringScripts class >> condenseCode [

	<script>
	self open: 'cms := CompiledMethod allInstances select: [:each |
each package ifNil: [ false ] ifNotNil: [:p |
	p name beginsWith: ''Zinc'' ] ].


cms do: [:cm |
    ((RBRefactoryChangeFactory instance)
         addMethodSource: (ReMethodSourceCleaner clean: cm sourceCode) in: cm origin) execute ]'
]

{ #category : 'class refactoring' }
RefactoringScripts class >> rewritePatterns [

	<script>
	self open: 'r := RBParseTreeRewriter new.
r replace: ''`@receiver assert: `@arg = `@arg2'' with: ''`@receiver assert: `@arg equals: `@arg2''.
r replace: ''`@receiver deny: `@arg = `@arg2'' with: ''`@receiver deny: `@arg equals: `@arg2''.


classes := TestCase allSubclasses select: [ :e | e package name first = $c ].

classes do: [ :class |

	class localMethods select: [ :m | m selector beginsWith: ''test'' ] thenDo: [ :m |
		n := m parseTree.
		(r executeTree: n) ifTrue: [ class compile: n formattedCode].
		 ]
	 ]
	displayingProgress: [ :c | c printString ]'
]

{ #category : 'see class side' }
RefactoringScripts >> seeClassSide [
]
