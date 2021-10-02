---
layout: post
title: Quicklook - MacOS
date: 2021-10-01 11:44
category: code
author: Mark
tags:
  - macOS
summary: Tips for using QuickLook to preview files in MacOS
image: /code/assets/qlicon.jpg
noFeatureImage: true
---

QuickLook is the tool that Finder uses in MacOS to provide previews of file contents when pressing space bar on a file in Finder. `qlmanage` is the command line tool used to administer QuickLook.

## QlManage

Use `qlmanage` to diagnose and change QuickLook settings.

```
Usage: qlmanage [OPTIONS] path...
	-h		Display this help
	-r		Force reloading Generators list
	-r cache	Reset thumbnail disk cache
	-m [name ...]	Display statistics about quicklookd. Stats names:
			* plugins	Show the generators list
			* server	Show quicklookd life information
			* memory	Show quicklookd memory consumption
			* burst		Show statistics about the last burst
			* threads	Show concurrent accesses stats
			* other		Show other information about quicklookd
	-p		Compute previews of the documents
	-t		Compute thumbnails of the documents
	-x		Use quicklookd (remote computation)
	-i		Compute thumbnail in icon mode
	-s size		Size for the thumbnail
	-f factor	Scale factor for the thumbnail
	-F factor	Scale factor for the thumbnail, draw downscaled and compare to 1x
	-z		Display generation performance info (don't display thumbnails)
	-o dir		Output result in dir (don't display thumbnails or previews)
	-c contentType	Force the content type used for the documents
	-g generator	Force the generator to use
```

To find the QuickLook generator for a specific file extension:

```sh
qlmanage -m | grep "md"
```

To test a quicklook generator run it explicitly on a file you want to view. For example:

```sh
qlmanage -p /path/to/sample/file.ext
```

## Unsigned QuickLook Generators

In more recent versions of MacOS (Mohave, Big Sur, etc...) new security requirements have been put in place. This means a number of older QuickLook generators are not signed and so do not work without approval. To approve the extensions you must do the following:

1. Install the QuickLook generator, e.g. `brew install qlcolorcode`
2. On your terminal, run `xattr -cr ~/Library/QuickLook/QLColorCode.qlgenerator` (use sudo if needed), replacing `QLColorcode` with whatever the name of the QuickLook plugin
3. Run `qlmanage -r`
4. Run `qlmanage -r cache`
5. Restart Finder by running `killall Finder`

## QuickLook Generators I use

- QLStephen - <https://whomwah.github.io/qlstephen/>  
  This Quick Look plug-in allows you to view most text files without specific extensions (README,Makefile etc)

- QLColorCode - <https://github.com/anthonygelibert/QLColorCode>  
  Quick Look plug-in that renders source code with syntax highlighting
- QLMarkdown - <https://github.com/toland/qlmarkdown>  
  QLMarkdown is a simple QuickLook generator for Markdown files

```sh
brew install qlstephen qlcolorcode qlmarkdown
```
