"
A bunch on scripts.
"
Class {
	#name : 'Scripts',
	#superclass : 'Object',
	#category : 'PharoSettings-Scripts',
	#package : 'PharoSettings-Scripts'
}

{ #category : 'scripts' }
Scripts class >> addClassInitializationLogs [

	<script>
	self open: 'CompiledMethod allInstances
	select: [ :method | method isClassSide and: [ method selector = #initialize ] ]
	thenDo: [ :method |
			method methodClass compile: method sourceCode , ''
	.SystemNotification signal: (''''Initializing '''', '' , method methodClass printString , '' asString)'' ]'
]

{ #category : 'scripts' }
Scripts class >> bootstrapScript [

	<script>
	self open: '"To launch in the bootstrap image"
	
repositoryPathString := ''/Users/cyril/Library/Preferences/pharo/GitRepositories/pharo-project/pharo/src''.

[  
[ 
  Metacello new
	  baseline: ''PharoBootstrapProcess'';
	  repository: ''tonel://'', repositoryPathString;
	  load ]
      on: IceGenericError
      do: [ :exception |
        Metacello new
	        baseline: ''PharoBootstrapProcess'';
	        repository: ''tonel://'', repositoryPathString;
	        load
      ].
] on: Warning do: #resume.

[
	versionInfo := (PBVersionInfo fromLongGitDescribe: ''Pharo10.0-aaaddb-aaaa-vbb'')
		buildNumber: 42;
		yourself.
		 
		
(PBBootstrap for64Bits
		versionInfo: versionInfo;
		repositoryLocation: ''/Users/cyril/Library/Preferences/pharo/GitRepositories/pharo-project/pharo'' asFileReference;
		imageName: ''bootstrap.image'';
		yourself) bootstrap] spy '
]

{ #category : 'scripts' }
Scripts class >> compileIcon [

	<script>
	self open: 'iconName := ''myLogo''.
icon := ''/Users/cyrilferlicot/Google Drive/Personnel/Furry/IMG_3509.JPG'' asFileReference.

ThemeIcons compile:  iconName , ''Contents
	^ '''''' , (Base64MimeConverter mimeEncode: icon binaryReadStream) contents , '''''''' classified: ''*Material-Design-Lite-Core''.

ThemeIcons compile: iconName, ''
	^ icons
			at: #'''''' , iconName , ''''''
			ifAbsentPut:[ Form fromBinaryStream: self '' , iconName , ''Contents base64Decoded asByteArray readStream ]'' classified: ''*Material-Design-Lite-Core''.

Smalltalk ui icons perform: iconName asSymbol'
]

{ #category : 'scripts' }
Scripts class >> downloadBooks [
	<script>
	self open: '| folder novelFolder page urls |
	folder := (FileLocator documents / ''Novels'') ensureCreateDirectory.
	#(''a-will-eternal'' ''i-shall-seal-the-heavens'' ''stellar-transformations'' ''warlock-of-the-magus-world'' ''battle-through-the-heavens'' ''desolate-era'' ''i-reincarnated-for-nothing'' ''legend-of-the-dragon-king'' ''renegade-immortal'' ''sage-monarch'' ''tales-of-demons-and-gods'' ''the-unrivaled-tang-sect'')
		do: [ :novel |
			novelFolder := folder / novel.
			novelFolder ensureCreateDirectory.

			page := XMLHTMLParser parseURL: ''https://www.wuxiaworld.com/novel/'' , novel.

			urls := (page xpath: ''''//li[@class=''chapter-item'''']/a/@href'') stringValues collect: [ :e | ''https://www.wuxiaworld.com'' , e ].

			urls
				do: [ :url |
					ZnClient new
						url: url;
						downloadTo: novelFolder / ((url copyAfterLast: $/) , ''.html'') ]
				displayingProgress: [ :u | u ] ]
		displayingProgress: [ :novel | novel ]'
]

{ #category : 'scripts' }
Scripts class >> findDependenciesToAPackage [

	<script>
	self open: 'report := StDependencyChecker new computeImageDependencies.


(report knownDependantsOf: ''Garage'') inspect'
]

{ #category : 'scripts' }
Scripts class >> findVaribleUsageInSubclasses [

	<script>
	self open: 'origin := SpPresenter.
variables := origin instVarNames.

variables
	inject: Dictionary new
	into: [ :dict :var |
		dict
			at: var put: ((origin slots detect: [ :e | e name = var ]) usingMethods collect: #methodClass as: Set);
			yourself ]'
]

{ #category : 'instance creation' }
Scripts class >> methodAnnouncementReceived: anAnnouncement [
	"No need to rebuild if it contains the world menu pragma"

	self flag: #pharo6. "Menubar was introduced in Pharo 7"
	SystemVersion current major < 7 ifTrue: [ ^ self ].

	anAnnouncement methodAffected pragmas
		detect: [ :e | e selector = 'worldMenu' ]
		ifFound: [ :p | ^ self ].

	(anAnnouncement methodAffected methodClass includesBehavior: self class) ifTrue: [ MenubarMorph reset ]
]

{ #category : 'protocol' }
Scripts class >> open: aString [
	Smalltalk tools workspace openContents: aString
]

{ #category : 'scripts' }
Scripts class >> updateLauncherList [
	<script>
	self open: '
	"To execute in the Launcher image."
	| sources privateToken |

privateToken:= ''''.

sources := {
    "Pharo Language Server"
    PhLTemplateSource new
        type: #HttpListing;
        name: ''Pharo Language Server'';
        url: ''https://github.com/badetitou/Pharo-LanguageServer/releases'';
        filterPattern: ''href="([^"]*/(Pharo|Moose)[0-9][^"]*.zip)"'';
        templateNameFormat: ''{6} ({5})''.

    "Moose"
    PhLTemplateSource new
        type: #HttpListing;
        name: ''Moose'';
        url: ''https://github.com/moosetechnology/Moose/releases'';
        filterPattern: ''href="([^"]*/(Pharo|Moose)[0-9][^"]*.zip)"'';
        templateNameFormat: ''{6} ({5})''.

    "BL"
    PhLTemplateSource new
        type: PhLTemplateSource urlGroupType;
        name: ''BL'';
        templates: {
            PhLTemplateSource new
                type: PhLTemplateSource urlType;
                name: ''MooseBL'';
                url: ''https://gitlab.forge.xxxxx.com/api/v4/projects/219/jobs/artifacts/master/download?job=Moose64-8.0&private_token='', privateToken;
                yourself
            }
        }.
    PhLUserTemplateSources sourcesFile writeStreamDo: [ :s |
        (STON writer on: s)
            newLine: String lf;
            prettyPrint: true;
            nextPut: sources ]'
]

{ #category : 'see class side' }
Scripts >> seeClassSide [
]
