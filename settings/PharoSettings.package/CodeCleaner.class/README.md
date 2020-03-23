CodeCleaner cleanEqualityTestOfClasses: (TestCase allSubclasses select: [ :e | e package name includesSubstring: 'MDL' ]).

CodeCleaner cleanEqualityTestOfPackages: (RPackageOrganizer includingSubstring: 'MDL')
