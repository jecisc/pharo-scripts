conveniance
tweakGCParameters
	<name: 'Tweak GC parameters'>

	"Increase eden size. This will reduce the amount of scavenge and speed up algo creating a lot of new objects been discard fast."
	Smalltalk vm parameterAt: 45 put: 64 * 1024 * 1024.

	"Increase growth headroom. When the memory will need to grow, it will directly allocate more room."
	Smalltalk vm parameterAt: 25 put: 32 * 1024 * 1024.

	"Increase shrinking threashold to shrink the memory less often"
	Smalltalk vm parameterAt: 24 put: 64 * 1024 * 1024.

	"Change the full GC ratio to only GC when the heap grows by 70% instead of 33% before."
	Smalltalk vm parameterAt: 55 put: 0.7