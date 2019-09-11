instance creation
methodAnnouncementReceived: anAnnouncement
	"No need to rebuild if it contains the world menu pragma"

	anAnnouncement methodAffected pragmas
		detect: [ :e | e selector = 'worldMenu' ]
		ifFound: [ :p | ^ self ].
	({self.
	self class}
		anySatisfy: [ :class | anAnnouncement methodAffected methodClass = class ])
		ifTrue: [ MenubarMorph reset ]