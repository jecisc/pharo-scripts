initialization
initialize
	super initialize.
	rewriter := RBParseTreeRewriter new.
	methodMatchBlock := [ :m | true ]