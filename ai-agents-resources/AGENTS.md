# My coding conventions 

## General
- Do not use abbreviations except when the abbreviation is better known that its original name (such as HTTP). I forbid the use of temporaries or argument names with only one letter
- In multi paradigm languages, I prefer to code in OOP except if say otherwise or if I participate to a project already coded an another paradigm
- Add documentation on this that are complex but do not add comments to code that is self explanatory
- I want my code to be the simplest and more readable possible except if it can create a big bottleneck in performances
- Avoid to add dependencies iff possible. If you wish to bring a new dependency ask me if I want it
- Document public API
- Do not wrap in the middle of a line before 200 character. We now have wide screens, let's use it
- If you update code, check that class comments are still up to date
- I am personaly using fish as shell
- To know about me: I like to code in TDD if possible

## Python 
- Use tabs for indentation and not spaces
- Use type hint if possible

## Pharo

### Pharo specificities
- If a pharo mcp is connected check /Users/cyril/Library/Preferences/pharo/GitRepositories/Evref-BL/MCP/templates. If this folder exists, read the files inside. In case of contradiction the priority is: AGENTS.md of the project > ~/.opencode/AGENTS.md > MCP/AGENTS.md
- Pharo usually compiles code in memory, but it persist the code on disk when commiting in files that are using the Tonel format. Since those files are generated, the structure is really standard. Make sure to follow this structure. Methods should be first the class side methods, then the instance side one. For both they are ordered alphabetically
- Tonel method bodies require the bracket style: `selector [ body ]`. Conversely, when saving methods directly in the image (e.g. via the MCP), compile them WITHOUT brackets, since Pharo stores the method source bracket-less
- In Pharo, `Symbol` answers `true` to `#isString` (Symbol is not a String subclass but overrides `isString`), so checks like `aFlagArgument isString` also match symbols
- Pharo currently uses cr for line returns when the code is inside Pharo (in Tonel files, it is the line return of the OS). Use cr instead of lf if you compile some code in Pharo
- In Pharo indexes starts at 1 and not 0 by standard
- If you need to check the code of dependencies on the project, if there is a MCP active and the code in the image, it would be better to check in the image instead of asking me permissions to check all the clones on my computer
- If a MCP is connected, except if I tell you otherwise, only update the Pharo code and not the Tonel files on disk. The tonel files are overriten when we commit from Pharo so it is useless to sync them. Pharo will do it when I save my changes
- Traits copy their methods and slots into each using class's method dictionary, so implementor/sender searches of a trait-provided selector return one near-identical copy per user. Before reading or editing a method that appears on many classes, check its origin: `(SomeUser >> #selector) origin`. If it answers a `*Trait`, that trait is the single canonical definition — read/edit only that one method (via `pharo_method_get` on the trait, or the trait's `Foo.extension.st` file), and use `includeSource: false` for broad searches. Note a trait's methods may themselves be extension methods (protocol `*Package-Name`) in a different package than the trait definition (e.g. `FASTTCanBeLocalDeclaration` is defined in `FAST-Core-Model`, but its `localDeclaration`/`localUses` live in `FAST-Core-Tools/FASTTCanBeLocalDeclaration.extension.st`).
- assertCollection:hasSameElements: ignores multiplicity in current images (#(a a) vs #(a) passes). Add an explicit size assertion to catch duplicates

### Coding rules
- Use #isNotNil and not #notNil. Use #isNotEmpty and not #notEmpty
- Avoid the use of #isKindOf: and #respondsTo: when possible. If you want to use it, ask me if it's ok in this context
- If you override a method, favors the use of the protocol in the superclass
- If you send multiple messages to the same receiver, prefer a cascade except for assertions in a test case
- Class initializations should not have a super initialize call
- In blocks, do not prefix variable names by "each". If it is a selector, call it "selector" and not "eachSelector"
- Do not wrap class comments or comments. Return to a new line only for new sentences, not in the middle of a sentence
- Always apply the Pharo formatter to every method you add or change, tests included, in every project and without being asked. In the image: `formatted := method ast formattedCode`, convert the line returns to cr (`copyReplaceAll: String lf with: String cr`) and recompile it in the same class and protocol (`method protocol name`). Do it before reporting the work as done, then run the tests again

#### Testing
- Do not do `self assert: a == b` but `self assert: a identicalTo: b`
- Do not write tests for simple getters and setters
- When comparing if a collection is empty or not, favor #assertEmpty: and #denyEmpty:

## Don't
- Don't use emoji if it does not bring value
- Avoid premature abstractions

## Backlogs (all agents, all sessions)

Read `backlog/README.md` before starting work that touches the Pharo ecosystem.

- **Log every problem you hit** in `backlog/agent-findings.md`: bugs, errors, workarounds, friction, things that would make future work simpler, and suspected security issues. Log it even if you worked around it. Do not silently ignore a problem.
- **Log improvements, not only problems.** When you see a way to make a tool, MCP server, skill, plugin or project better, log it as `Type: improvement` even if nothing broke. The Pharo MCP (`pharo` server, its `tool_*`, `method_*`, `class_*`, `test_run` and `image_evaluate` tools) is in scope: an unclear tool description, a missing parameter, a slow or noisy result, an error that does not say what to do next.
- **Log missing or outdated documentation** as `Type: doc`: a project, tool or skill lacks docs for something you needed, or its docs contradict the code or the current behaviour. Name the project in **Area** and the file or missing topic in **Evidence**.
- **Be precise.** **Area** names the exact project, tool, server or file (`pharo` MCP, `tool_search`, `Evref-BL/Pharo-Tree-Sitter`), not a category. **Evidence** holds the command, the exact error text or the file and line. **Summary** says what is wrong or what would be better, in one or two sentences, without speculation about the cause unless you verified it.
- Mention in your reply to the user when you add a finding. Give its ID.
- Most dependencies, including Pharo itself, are projects the user contributes to. Set **Upstream** to `yes` when a fix belongs there.
- Edit `backlog/user-backlog.md` **only when the user asks you to**. Read it at the start of a session to know what the user wants to work on.
- Get new IDs with `python3 backlog/next-id.py A` (or `U`) right before writing an entry. Never reuse an ID. Update a finding's **Status** when you resolve it, instead of deleting it.
- When you set a finding or backlog item to `done` or `wontfix`, add a **Resolved:** date and run `python3 backlog/archive-resolved.py` (under `ai-agents-resources/`). This moves it to the weekly file in `backlog/archive/`.

## Keep setup.sh up to date

`setup.sh` (under `ai-agents-resources/`) rebuilds this setup on a new machine. When you add or change a skill, plugin, marketplace entry, tool dependency, or Claude/opencode config, update `setup.sh` (and the templates in `claude/templates/` or `opencode/`) in the same change. Never put secrets in templates. Use `REPLACE_WITH_YOUR_KEY` placeholders.
