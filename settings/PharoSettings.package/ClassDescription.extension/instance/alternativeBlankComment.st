*PharoSettings
alternativeBlankComment
	| existingComment stream |
	(existingComment := self instanceSide organization classComment) ifNotEmpty: [ ^ existingComment ].
	(stream := (String new: 100) writeStream)
		<<
			'Description
--------------------

One line summary. For example, "I represent a paragraph of text".

Three sentences about my main responsibilities - what I do, what I know.

State my main collaborators and one line about how I interact with them.

Public API and Key Messages
--------------------

- #
- #
- #

Examples
--------------------



Internal Representation and Key Implementation Points.
--------------------'.
	self instVarNames
		ifNotEmpty: [ stream
				cr;
				cr;
				nextPutAll: '    Instance Variables' ].
	self instVarNames asSortedCollection
		do: [ :each |
			stream
				cr;
				tab;
				nextPutAll: each;
				nextPut: $:;
				tab;
				tab;
				nextPutAll: '<Object>' ].
	^ stream
		cr;
		contents