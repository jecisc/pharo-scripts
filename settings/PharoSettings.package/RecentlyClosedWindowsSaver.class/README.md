Description
--------------------

I am an utility holding the latest closed windows and allowing one to open them again.

By default I keep 10 windows but this number can change.

I will flush the windows when we quit the image.

Public API and Key Messages
--------------------

- #restoreWindow 		Allows one to restore a window.
- #flush 					Flush the currently kept windows.

Examples
--------------------

	RecentlyClosedWindowsSaver default restoreWindow.
	
	RencentlyClosedWindowsSaver default numberOfWindowsToKeep: 15.
	
	RencentlyClosedWindowsSaver default flush.
	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	cache:		<aLRUCache>		Cache keeping the latest 10 windows.
