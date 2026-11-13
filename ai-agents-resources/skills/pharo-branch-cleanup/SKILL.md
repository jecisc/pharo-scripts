---
name: pharo-branch-cleanup
description: Clean the Pharo code changed by a branch after a big change (refactoring, migration, many commits). Finds, in a running image through the Pharo MCP, unused or write-only variables, methods equivalent to the inherited one or only calling super, methods duplicated with a used trait or with sibling classes, protocols differing from the overridden method or spelled several ways, unclassified methods, dead code, undeclared variables and unimplemented messages, comments naming classes or selectors that no longer exist, lf line endings, classes without comment and Renraku critiques. Use when the user asks to clean, tidy, polish or review the quality of a branch or of a big change in Pharo before a PR.
---

# Clean the code of a Pharo branch

The checks run in the image, on the code the branch changed: the methods changed since the merge base, and the methods compiled in the image after the last commit (not yet written by Iceberg).

## 1. Compute the scope

From the root of the git repository:

```sh
~/.claude/skills/pharo-branch-cleanup/scope.py origin/Pharo15 > <scratchpad>/scope.st
```

The first argument is the branch the work started from, the second the source directory (default `src`). The script compares every Tonel method of the merge base with the working tree, and prints a Smalltalk expression that sets the global `PharoCleanupScope`: the changed packages (plus the dirty packages of Iceberg), the changed methods, the classes whose definition or comment changed, and the date of HEAD.

Evaluate it in the image:

```smalltalk
Smalltalk compiler evaluate: '<scratchpad>/scope.st' asFileReference contents
```

## 2. Run the checks

`checks.st` answers a Markdown report. It takes a few seconds for a branch of about 800 changed methods, but the Renraku critiques grow with the scope and an MCP call can time out (and abandon the evaluation), so run it in a background process that writes the report, then read the file when it exists:

```smalltalk
[ | result |
  result := Smalltalk compiler evaluate: '~/.claude/skills/pharo-branch-cleanup/checks.st' asFileReference contents.
  '<scratchpad>/cleanup-report.md' asFileReference ensureDelete; writeStreamDo: [ :stream |
	stream nextPutAll: (result copyReplaceAll: String cr with: String lf) ] ]
	forkAt: Processor userBackgroundPriority named: 'Cleanup checks'
```

Use the absolute path of `checks.st` (resolve `~`). For a quick pass, put `(Smalltalk at: #PharoCleanupScope) at: #critiques put: false` first: the other checks take a few seconds and can be evaluated directly.

## 3. Triage the report

Every finding is a candidate. Read the code before changing it, and sort the findings for the user:

- **Fix**: what the branch introduced or made obsolete (a variable it stopped reading, a comment naming a class it removed, an override it made identical to the inherited method, a protocol it got wrong).
- **Ask**: what changes behaviour or API (removing a public method without senders, pulling up duplicated methods, renaming protocols across a package).
- **Leave**: what was already there before the branch, unless the user wants it, and false positives (methods called by reflection or from other repositories, accessors kept for API, test fixtures).

Present the list grouped this way before editing, unless the user asked to fix everything.

What the sections mean:

| Section | What to do |
|---|---|
| Unused or write-only variables | Remove the variable and its accessors, or read it where it was meant to be used |
| Methods equivalent to the inherited method / only calling super | Remove the override (check that no subclass relies on it being there) |
| Methods duplicated in the trait composition | Remove the copy, or keep an intended override |
| Methods duplicated in sibling classes | Pull up to the common superclass when all subclasses share it |
| Protocols of overriding methods | Use the protocol of the overridden method, unless the package has its own convention |
| Protocol names | Use one spelling per package; classify unclassified methods |
| Dead code candidates | Check senders outside the image (other repositories, `perform:` with built symbols) before removing |
| Undeclared variables and messages implemented nowhere | Real bugs, or references to code of a package which is not loaded |
| Comments naming unknown classes or selectors | Update the comment to the current names |
| Line endings | Convert lf to cr (Pharo sources use cr) |
| Classes without comment | Write one, in the style of the package |
| Renraku critiques | Fix the ones the branch introduced |

## 4. Fix and verify

- Change the code through the image (the Pharo MCP), converting lf to cr in sources and comments.
- Keep each kind of fix separate so the user can review it, and propose a commit message per kind.
- Run the tests of the touched packages, then run the scope and the checks again: the fixed findings must be gone and no new one must appear.
- The image does not show load order problems, since everything is already loaded. Check that every class added or moved by the branch has its superclass and its traits in a package that its package requires in the baseline (directly or through other requirements), and that every extension method is on a class of such a package, or the package will not load in a fresh image (`Package X depends on the following classes`). Compute the requirements from the baselines and compare them with the superclass, trait and extension class of every class and method of the touched packages.
- Do not touch packages outside the scope, or the user's own packages, without asking.
- At the end, remove the global: `Smalltalk globals removeKey: #PharoCleanupScope ifAbsent: [ ]`.

## Limits

- Classes are matched by name: renamed classes look new, and their methods all count as changed.
- Methods compiled in the image after the last commit count as changed, even if their source did not change.
- The dead code check only sees the image: a selector sent from another repository, or built at run time, looks dead.
- Comments are scanned for words that look like class names of the project (camel case, with a prefix shared by at least five classes of the scope) and for `#selectors`.
