#!/usr/bin/env python3
"""Prints the Smalltalk expression which sets PharoCleanupScope for checks.st.

Usage (from the root of the git repository):
    scope.py [base-ref] [source-dir]
base-ref: the branch the work started from (default origin/Pharo15); the merge base with HEAD is used.
source-dir: the directory holding the Tonel packages (default src).

It compares the Tonel files of the merge base with the working tree, method by method, and lists:
- the packages with a changed file,
- the methods added or changed (source or protocol), as 'Class>>selector' or 'Class class>>selector',
- the classes whose definition or comment changed.
Changes made in the image and not yet written by Iceberg are found by checks.st with the date of HEAD,
and their packages are added by the expression from the dirty packages of Iceberg.
"""
import re
import subprocess
import sys
import os

base_ref = sys.argv[1] if len(sys.argv) > 1 else 'origin/Pharo15'
src = sys.argv[2] if len(sys.argv) > 2 else 'src'


def git(*args):
    return subprocess.run(['git', *args], capture_output=True, check=True).stdout.decode('utf-8', 'replace')


base = git('merge-base', 'HEAD', base_ref).strip()
since = git('log', '-1', '--format=%cI', 'HEAD').strip()
files = set(git('diff', '--name-only', base, '--', src).split())
files |= set(git('ls-files', '--others', '--exclude-standard', '--', src).split())

HEADER = re.compile(r'^([A-Za-z0-9_]+(?: class)?) >> (.+?) \[\s*$')
CATEGORY = re.compile(r"^\{ #category : '(.*)' \}\s*$")


def selector_of(signature):
    keywords = re.findall(r'([A-Za-z0-9_]+:)', signature)
    return ''.join(keywords) if keywords else signature.split()[0]


def parse(text):
    """Answers (definition, {method: (protocol, source)}) of a Tonel file."""
    lines = re.split(r'\r\n|\r|\n', text)
    methods = {}
    definition = []
    index = 0
    protocol = None
    while index < len(lines):
        line = lines[index]
        category = CATEGORY.match(line)
        header = HEADER.match(line)
        if category:
            protocol = category.group(1)
        elif header:
            body = []
            index += 1
            while index < len(lines) and lines[index] != ']':
                body.append(lines[index])
                index += 1
            methods[header.group(1) + '>>' + selector_of(header.group(2))] = (protocol, '\n'.join(body).strip())
            protocol = None
        elif not methods:
            definition.append(line)
        index += 1
    return '\n'.join(definition).strip(), methods


def read_base(path):
    try:
        return git('show', base + ':' + path)
    except subprocess.CalledProcessError:
        return ''


packages, methods, classes = set(), set(), set()
for path in sorted(files):
    match = re.match(re.escape(src) + r'/([^/]+)/([^/]+)\.(class|extension|trait)\.st$', path)
    if not match:
        if path.startswith(src + '/'):
            packages.add(path.split('/')[1])
        continue
    packages.add(match.group(1))
    new_text = open(path, encoding='utf-8', errors='replace').read() if os.path.exists(path) else ''
    old_definition, old_methods = parse(read_base(path))
    new_definition, new_methods = parse(new_text)
    if match.group(3) != 'extension' and new_text and old_definition != new_definition:
        classes.add(match.group(2))
    for key, value in new_methods.items():
        if old_methods.get(key) != value:
            methods.add(key)


def literal_array(items, quote):
    return ' '.join(quote + item.replace("'", "''") + quote if quote == "'" else '#' + item for item in sorted(items))


print(f"""| repo packages |
packages := #( {literal_array(packages, "'")} ) asSet.
repo := IceRepository registry detect: [ :each | each location notNil and: [ each location fullName = '{os.getcwd()}' ] ] ifNone: [ nil ].
repo ifNotNil: [ repo workingCopy refreshDirtyPackages. packages addAll: ((repo workingCopy packages select: [ :each | each isDirty ]) collect: [ :each | each name ]) ].
Smalltalk at: #PharoCleanupScope put: (Dictionary new
	at: #packages put: (packages select: [ :name | PackageOrganizer default hasPackage: name ]) asArray sort;
	at: #changedMethods put: #( {literal_array(methods, "'")} );
	at: #changedClasses put: #( {literal_array(classes, '#')} );
	at: #since put: '{since}';
	yourself).
(Smalltalk at: #PharoCleanupScope) size""")
