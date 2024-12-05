Extension { #name : 'SDL_Window' }

{ #category : '*PharoSettings' }
SDL_Window >> createDefaultRenderer [

	^ self createRenderer: -1 flags: SDL_RENDERER_PRESENTVSYNC
]
