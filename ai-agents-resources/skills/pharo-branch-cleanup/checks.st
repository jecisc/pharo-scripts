"Code quality checks for the code changed by a branch, in a running Pharo image.
Before evaluating me, put the scope in the global PharoCleanupScope, a Dictionary:
	#packages -> the names of the packages to check
	#changedMethods -> the methods changed in git, as strings 'Class>>selector' or 'Class class>>selector'
	#changedClasses -> the names of the classes whose definition or comment changed in git
	#since -> an ISO date and time string: methods compiled after it count as changed (the date of HEAD), or nil
	#critiques -> false to skip the Renraku critiques, the slowest check (default true)
scope.py computes it. A method is changed when it is in #changedMethods or was compiled after #since. A class is changed when it is in #changedClasses or has a changed method.
I answer a report, one section per check. Every finding is a candidate: read the code before changing anything."
| scope packages changedClassNames changedMethodKeys isAccessor scopePrefixes since classes changedMethods isChanged changedClassesInScope report section add sent implemented referenced normalize prefixes knownGlobal unknownClassesIn selectorsIn critiquesByRule isEntryPoint |
scope := Smalltalk at: #PharoCleanupScope.
packages := (scope at: #packages) collect: [ :name | PackageOrganizer default packageNamed: name ].
changedClassNames := (scope at: #changedClasses ifAbsent: [ #() ]) asSet.
changedMethodKeys := (scope at: #changedMethods ifAbsent: [ #() ]) asSet.
since := scope at: #since ifAbsent: [ nil ].
classes := (packages flatCollect: [ :package | package definedClasses ]) asSet.
isChanged := [ :method |
	(changedMethodKeys includes: method methodClass name , '>>' , method selector)
		or: [ since notNil and: [ | stamp | stamp := method timeStamp. stamp notNil and: [ stamp > since ] ] ] ].
changedMethods := (packages flatCollect: [ :package | package methods ]) select: [ :method | isChanged value: method ].
changedClassesInScope := (classes select: [ :class |
	(changedClassNames includes: class name) or: [ changedMethods anySatisfy: [ :method | method methodClass instanceSide == class ] ] ]) asArray sort: [ :a :b | a name <= b name ].
report := WriteStream on: String new.
section := [ :title | report cr; nextPutAll: '## '; nextPutAll: title; cr ].
add := [ :line | report nextPutAll: '- '; nextPutAll: line; cr ].
"One pass over the image instead of a query per selector: the selectors sent or used as symbols, the selectors implemented (with their number of implementors) and the variables referenced."
sent := IdentitySet new.
implemented := IdentityBag new.
referenced := IdentitySet new.
SystemNavigation default allBehaviorsDo: [ :behavior |
	behavior selectorsDo: [ :selector | implemented add: selector ].
	behavior methodsDo: [ :method |
		sent addAll: method messages.
		method allLiterals do: [ :literal |
			literal isSymbol ifTrue: [ sent add: literal ].
			literal isVariableBinding ifTrue: [ referenced add: literal ] ] ] ].
isAccessor := [ :method | | statements |
	statements := method ast statements.
	statements size = 1 and: [ | statement | statement := statements first. (statement isReturn and: [ statement value isVariable or: [ statement value isLiteralNode ] ]) or: [ statement isAssignment and: [ statement value isVariable ] ] ] ].
isEntryPoint := [ :method |
	"Methods with a pragma are usually collected by it (menus, settings, declarations), so they are not dead."
	method pragmas notEmpty
		or: [ (method methodClass instanceSide inheritsFrom: TestCase) or: [ method methodClass instanceSide isManifest ] ] ].

report nextPutAll: '# Cleanup report'; cr.
add value: packages size printString , ' packages, ' , changedClassesInScope size printString , ' changed classes, ' , changedMethods size printString , ' changed methods'.

section value: 'Unused or write-only variables (changed classes)'.
changedClassesInScope do: [ :class |
	{ class. class classSide } do: [ :side |
		side instVarNames do: [ :name |
			| readers writers |
			readers := side withAllSubclasses flatCollect: [ :each | each whichSelectorsRead: name ].
			writers := side withAllSubclasses flatCollect: [ :each | each whichSelectorsAccess: name ].
			writers isEmpty
				ifTrue: [ add value: side name , ' ' , name , ' is never used' ]
				ifFalse: [ readers isEmpty ifTrue: [ add value: side name , ' ' , name , ' is written but never read' ] ] ] ].
	class classVariables do: [ :variable |
		(referenced includes: variable) ifFalse: [ add value: class name , ' class variable ' , variable name , ' is never used' ] ] ].

section value: 'Methods equivalent to the inherited method'.
changedMethods do: [ :method |
	| inherited |
	inherited := method methodClass superclass ifNotNil: [ :superclass | superclass lookupSelector: method selector ].
	inherited ifNotNil: [
		method ast = inherited ast ifTrue: [ add value: method printString , ' is the same as ' , inherited printString ].
		(method ast statements size = 1 and: [ | statement | statement := method ast statements first. statement isReturn ifTrue: [ statement := statement value ]. statement isMessage and: [ statement isSuperSend and: [ statement selector = method selector and: [ (statement arguments collect: [ :each | each isVariable ifTrue: [ each name ] ifFalse: [ nil ] ]) asArray = method ast argumentNames asArray ] ] ] ]) ifTrue: [
			add value: method printString , ' only calls super' ] ] ].

section value: 'Methods duplicated in the trait composition'.
changedClassesInScope do: [ :class |
	{ class. class classSide } do: [ :side |
		side traits do: [ :trait |
			side localMethods do: [ :method |
				((trait includesSelector: method selector) and: [ ((trait >> method selector) isSubclassResponsibility or: [ (trait >> method selector) sendsSelector: #explicitRequirement ]) not ]) ifTrue: [
					| traitMethod |
					traitMethod := trait >> method selector.
					method ast = traitMethod ast
						ifTrue: [ add value: method printString , ' duplicates ' , traitMethod printString ]
						ifFalse: [ add value: method printString , ' overrides the trait method ' , traitMethod printString , ' (check it is intended)' ] ] ] ] ] ].

section value: 'Methods duplicated in sibling classes (pull up?)'.
changedMethods do: [ :method |
	| superclass siblings |
	superclass := method methodClass superclass.
	(superclass notNil and: [ (packages includes: superclass package) and: [ (isAccessor value: method) not and: [ method pragmas isEmpty ] ] ]) ifTrue: [
		siblings := (superclass subclasses copyWithout: method methodClass) select: [ :each | (each includesSelector: method selector) and: [ (each >> method selector) ast = method ast ] ].
		siblings ifNotEmpty: [ add value: method printString , ' is also in ' , (', ' join: (siblings collect: [ :each | each name ])) ] ] ].

section value: 'Protocols of overriding methods'.
changedMethods do: [ :method |
	| inherited |
	inherited := method methodClass superclass ifNotNil: [ :superclass | superclass lookupSelector: method selector ].
	(inherited notNil and: [ method isExtension not and: [ inherited isExtension not and: [ method protocolName ~= inherited protocolName ] ] ]) ifTrue: [
		add value: method printString , ' is in ''' , method protocolName , ''' but overrides ' , inherited printString , ' in ''' , inherited protocolName , '''' ] ].

section value: 'Protocol names'.
normalize := [ :name | | key | key := (name asLowercase reject: [ :char | char isSeparator or: [ char = $- ] ]). (key endsWith: 's') ifTrue: [ key := key allButLast ]. key ].
packages do: [ :package |
	| byKey |
	byKey := Dictionary new.
	package definedClasses do: [ :class | { class. class classSide } do: [ :side |
		side protocols do: [ :protocol |
			protocol isEmpty ifTrue: [ add value: side name , ' has the empty protocol ''' , protocol name , '''' ].
			protocol isExtensionProtocol ifFalse: [ (byKey at: (normalize value: protocol name) ifAbsentPut: [ Set new ]) add: protocol name ] ] ] ].
	byKey do: [ :names | names size > 1 ifTrue: [ add value: package name , ' spells one protocol several ways: ' , (', ' join: (names asArray sort collect: [ :each | '''' , each , '''' ])) ] ] ].
changedMethods do: [ :method |
	(method protocolName = 'as yet unclassified' or: [ method protocolName isNil ]) ifTrue: [ add value: method printString , ' is not classified' ].
	(method isExtension and: [ (method protocolName asLowercase beginsWith: '*' , method package name asLowercase) not ]) ifTrue: [
		add value: method printString , ' is in ''' , method protocolName , ''' but belongs to ' , method package name ] ].

section value: 'Dead code candidates (no sender, no other implementor)'.
changedMethods do: [ :method |
	((isEntryPoint value: method) not and: [ method package isDeprecated not and: [ (sent includes: method selector) not and: [ (implemented occurrencesOf: method selector) = 1 ] ] ]) ifTrue: [
		add value: method printString , ((isAccessor value: method) ifTrue: [ ' (accessor)' ] ifFalse: [ '' ]) ] ].
changedClassesInScope do: [ :class |
	((class inheritsFrom: TestCase) or: [ class package isDeprecated or: [ class isManifest or: [ (class name beginsWith: 'BaselineOf') or: [ class subclasses notEmpty ] ] ] ]) ifFalse: [
		((referenced includes: class binding) or: [ sent includes: class name ]) ifFalse: [ add value: class name , ' is never referenced' ] ] ].

section value: 'Undeclared variables and messages implemented nowhere'.
changedMethods do: [ :method |
	method usesUndeclareds ifTrue: [ add value: method printString , ' uses an undeclared variable' ].
	(method messages reject: [ :selector | implemented includes: selector ]) ifNotEmpty: [ :missing |
		add value: method printString , ' sends ' , (', ' join: (missing asArray collect: [ :each | '#' , each ])) , ', implemented nowhere' ] ].

section value: 'Comments naming unknown classes or selectors'.
"Words which look like class names of the project: camel case, with a prefix shared by at least five classes of the scope (Cly, Syc...)."
prefixes := (classes asArray collect: [ :class | class name first: (3 min: class name size) ]) asBag.
scopePrefixes := (prefixes asSet select: [ :prefix | (prefixes occurrencesOf: prefix) >= 5 ]).
knownGlobal := [ :name | Smalltalk globals includesKey: name asSymbol ].
unknownClassesIn := [ :text |
	(((text ifNil: [ '' ]) copyReplaceAll: '.md' with: ' ') substrings: ' .,;:()[]{}''"<>#*/!?=-
	') select: [ :word | word size > 3 and: [ word first isUppercase and: [ (word count: [ :char | char isUppercase ]) >= 2 and: [ (word allSatisfy: [ :char | char isAlphaNumeric ]) and: [ (scopePrefixes includes: (word first: 3)) and: [ (knownGlobal value: word) not ] ] ] ] ] ] ].
selectorsIn := [ :text | | found |
	found := OrderedCollection new.
	((text ifNil: [ '' ]) allRangesOfRegexMatches: '#[a-zA-Z][a-zA-Z0-9:]*') do: [ :range | found add: ((text copyFrom: range first + 1 to: range last) copyWithout: $.) ].
	found select: [ :selector | | candidates |
		candidates := { selector. selector copyWithout: $: } , ((selector endsWith: ':') ifTrue: [ { selector allButLast } ] ifFalse: [ #() ]).
		candidates noneSatisfy: [ :each | (implemented includes: each asSymbol) or: [ (Smalltalk globals includesKey: each asSymbol) or: [ (Pragma allNamed: each asSymbol) notEmpty ] ] ] ] ].
changedClassesInScope do: [ :class |
	(unknownClassesIn value: class comment) asSet ifNotEmpty: [ :names | add value: class name , ' comment names ' , (', ' join: names asArray sort) ].
	(selectorsIn value: class comment) asSet ifNotEmpty: [ :names | add value: class name , ' comment names the unknown selectors ' , (', ' join: (names asArray sort collect: [ :each | '#' , each ])) ] ].
changedMethods do: [ :method |
	| comments |
	comments := ' ' join: method ast allComments.
	(unknownClassesIn value: comments) asSet ifNotEmpty: [ :names | add value: method printString , ' comment names ' , (', ' join: names asArray sort) ].
	(selectorsIn value: comments) asSet ifNotEmpty: [ :names | add value: method printString , ' comment names the unknown selectors ' , (', ' join: (names asArray sort collect: [ :each | '#' , each ])) ] ].

section value: 'Line endings (lf)'.
changedMethods do: [ :method | (method sourceCode includes: Character lf) ifTrue: [ add value: method printString ] ].
changedClassesInScope do: [ :class | ((class comment ifNil: [ '' ]) includes: Character lf) ifTrue: [ add value: class name , ' comment' ] ].

section value: 'Classes without comment'.
changedClassesInScope do: [ :class | ((class name beginsWith: 'BaselineOf') not and: [ class comment isNil or: [ class comment trimBoth isEmpty ] ]) ifTrue: [ add value: class name ] ].

section value: 'Renraku critiques of changed methods, by rule'.
"The slowest check: set #critiques to false in the scope to skip it."
(scope at: #critiques ifAbsent: [ true ]) ifFalse: [ add value: 'skipped' ].
critiquesByRule := Dictionary new.
((scope at: #critiques ifAbsent: [ true ]) ifTrue: [ changedMethods ] ifFalse: [ #() ]) do: [ :method |
	[ method critiques do: [ :critique | (critiquesByRule at: critique rule name ifAbsentPut: [ OrderedCollection new ]) add: method printString ] ]
		on: Error do: [ :error | add value: method printString , ' could not be critiqued: ' , error messageText ] ].
(critiquesByRule associations sort: [ :a :b | a value size >= b value size ]) do: [ :each |
	add value: each key , ' (' , each value size printString , '): ' , (', ' join: (each value asArray first: (each value size min: 8))) , (each value size > 8 ifTrue: [ ', ...' ] ifFalse: [ '' ]) ].

^ report contents
