---
name: pharo-class-comment
description: Write, revise or review the class comment of a Pharo class (the comment of a class definition), including test classes. Use when the user asks to write, rewrite, improve or check a class comment, or to document a class, its variables or its public API.
---

# Pharo class comments

A class comment is written in Microdown, in the first person, as the class speaking ("I represent…"). Keep it short and specific to this class. Write what the code does not say: the role of the class in the design, who uses it, and the decisions a maintainer cannot infer from the code.

## Before writing

- Read the class with the `pharo` tools: its superclass and subclasses, its instance, shared and class instance variables, and its current comment.
- For the life cycle section, find the real creators and users with the reference and sender searches of the `pharo` tools. Check every class and method you name. Do not name anything you have not seen in the image.
- If the class is in a hierarchy, read the superclass comment. Do not repeat it.

## Format

- Microdown. Use `## ` headings for sections.
- Class names and selectors go in backticks: `` `MyClass` ``, `` `MyClass>>#method` ``.
- Code goes in fenced blocks. Keep inline code to naming an API, such as `` `aDialog filter: aFilter` ``.
- Line endings depend on the Pharo version the class targets:
  - Pharo 15 and later: LF.
  - Before Pharo 15: CR (`Character cr`), never LF.
  - If you do not know the target version, ask before setting the comment.
- Convert the text to the right line endings before setting the comment. Then check the result: for CR, `aClass comment includes: Character lf` must answer false. For LF, `aClass comment includes: Character cr` must answer false.

## Voice and content

- Start with the first paragraph: "I represent…" or "I am…", in one or two sentences. Name the main collaborators and one or two key messages if they help a reader.
- Use plain sentences. Avoid filler and generic praise: "robust", "seamless", "comprehensive", "various", "enhance", "powerful".
- Do not restate what the methods do. Describe the concept, the role and the constraints.
- Do not mention tests, how to run them, or the sample and example methods, unless the section is about the public API.
- Keep simple english when possible.

## Optional sections

Include a section only when it says something the code does not. Drop it otherwise. Keep them in this order.

- **Life cycle** (or "Who creates me and who uses me"): a few numbered steps: who creates the instances (class and method), who keeps them, who sends them which messages, and how they change or go away. Name the collaborators as `` `Creator>>#method` ``. For a hierarchy, write this once in the root class. Subclasses only add what is specific to them.
- **Usage**: mutability, reuse, thread safety, statefulness, and when an instance becomes invalid. Use bullets only when the answers are not obvious.
- **Design Rationale**: why this design was chosen over the alternatives, the trade-offs, and the unusual behaviour that is intentional. Use bullets.
- **Implementation Notes**: subtleties a maintainer must know before changing the code, such as an intentional linear lookup or an order of operations that matters.
- **Invariants and Assumptions**: what the class guarantees, and what clients must guarantee.
- **Examples**: see below. Include them mainly for the public API.
- **Variables**: always the last section when the class has variables. See below.

## Examples

Examples are optional. Add them when the class is part of the public API, so readers can run the usage, and when the example result is worth showing.

- Do not put example code in the comment. Write it in methods, so it can be run and checked:
  - a class-side `instance…` method with the `<sampleInstance>` pragma, which answers an instance;
  - a class-side `example…` method with the `<example>` pragma, which uses the `instance…` methods and shows the result.
- The code block of the `## Examples` section calls the `example…` methods, such as `` MyClass exampleDefault ``. If the class has no `example…` method, it calls the `instance…` methods instead.
- Never put a method with side effects (a `<script>` pragma) in the comment.
- When the comment states an expected value, such as a displayed name or the result of a predicate, back it with a test.
- Test classes (subclasses of `TestCase`): no `## Examples` and no `## Life cycle` section. Do not say how to run them.

## Variables

When the class has instance variables, shared variables (class variables) or class instance variables, describe them in a `## Variables` section at the end of the comment. Use one subsection per kind that the class has, in this order, and skip the kinds it does not have:

```
## Variables

### Instance variables

- **name** (`Type`): what it holds and why.

### Shared variables

- **Name** (`Type`): what it holds and why.

### Class instance variables

- **name** (`Type`): what it holds and why.
```

- The type is the class or type the variable holds, such as `OrderedCollection of Announcement`, or `Object` when it can hold anything. If the variable is mostly `nil`, say when it is set.
- The description is one line, and says the role of the variable, not its implementation.
- Check every variable name against the class definition, and the type against the code that assigns it.

## Checks before writing

- Does the first paragraph say what the class is for?
- Is every class and method named in the comment in the image?
- Is every optional section still worth its place? Remove the ones that repeat the code.
- Are there any filler words or generic sentences?
- Is every variable described, with its type?
- Are the line endings right for the Pharo version?
