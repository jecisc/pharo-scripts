instance creation
methodAnnouncementReceived: anAnnouncement
	anAnnouncement methodAffected methodClass = self ifTrue: [ MenubarMorph reset ]