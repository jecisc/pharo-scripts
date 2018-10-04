# Native-Browser

A Small project to add the possibility to open native browser on a FileReference for Pharo

## Install Native-Browser

To install Native-Browser on your Pharo image you can just execute the following script:

```Smalltalk
    Metacello new
    	githubUser: 'jecisc' project: 'Native-Browser' commitish: 'master' path: 'src';
    	baseline: 'NativeBrowser';
    	load
```

To add Native-Browser to your baseline just add this:

```Smalltalk
    spec
    	baseline: 'NativeBrowser'
    	with: [ spec repository: 'github://jecisc/Native-Browser:master/src' ]
```

Note that you can replace the #master by another branch as #development or a tag as #v1.0.0, #v1.? or #v1.2.? .

## Usage

```Smalltalk
FileSystem workingDirectory openInNativeBrowser.

OSPlatform current openNativeBrowserOn: FileLocator home.
```

## OS Support

Currently working on:
- OSX (32/64)
- Linux (32/64)
- Windows (32)