instance creation
methodAnnouncementReceived: anAnnouncement
	({self . self class } anySatisfy: [ :class | anAnnouncement methodAffected methodClass = class ]) ifTrue: [ MenubarMorph reset ]