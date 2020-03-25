execution
rewriteMethodsOf: classes with: rewriter
	self rewriteMethodsOf: classes matching: [ :method | true ] with: rewriter