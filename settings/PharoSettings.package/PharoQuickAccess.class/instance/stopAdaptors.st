seaside scripts
stopAdaptors
	<name: #'Stop adaptors'>
	(self class environment at: #WAServerAdaptor) allSubInstances do: #stop