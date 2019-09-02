instance creation
methodAnnouncementReceived: anAnnouncement
	"No need to rebuild if it contains the world menu pragma"
	
	self flag: #pharo6. "Menubar was introduced in Pharo 7"
	SystemVersion current major < 7 ifTrue: [ ^ self ].

	anAnnouncement methodAffected pragmas detect: [ :e | e selector = 'worldMenu' ] ifFound: [ :p | ^ self ].

	({self . self class} anySatisfy: [ :class | anAnnouncement methodAffected methodClass = class ]) ifTrue: [ MenubarMorph reset ]