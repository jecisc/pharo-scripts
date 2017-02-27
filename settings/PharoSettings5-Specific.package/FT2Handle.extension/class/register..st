*PharoSettings5-Specific
register: aHandle
	(self registry includes: aHandle) ifTrue: [ ^ self ]. 
	self registry add: aHandle