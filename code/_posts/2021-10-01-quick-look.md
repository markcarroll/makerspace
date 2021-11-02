---
layout: post
title: Quicklook - MacOS
date: 2021-10-01 11:44
category: code
author: mark
tags: [macOS]
description: Tips for using QuickLook to preview files in MacOS
image: /code/assets/qlicon.jpg
featuredImage: false
toc: true
---

QuickLook is the tool that Finder uses in MacOS to provide previews of file contents when pressing space bar on a file in Finder. `qlmanage` is the command line tool used to administer QuickLook.

## QLManage

Use `qlmanage` to diagnose and change QuickLook settings.

```text
Usage: qlmanage [OPTIONS] path...
        -h              Display this help
        -r              Force reloading Generators list
        -r cache        Reset thumbnail disk cache
        -m [name ...]   Display statistics about quicklookd. Stats names:
                        * plugins       Show the generators list
                        * server        Show quicklookd life information
                        * memory        Show quicklookd memory consumption
                        * burst         Show statistics about the last burst
                        * threads       Show concurrent accesses stats
                        * other         Show other information about quicklookd
        -p              Compute previews of the documents
        -t              Compute thumbnails of the documents
        -x              Use quicklookd (remote computation)
        -i              Compute thumbnail in icon mode
        -s size         Size for the thumbnail
        -f factor       Scale factor for the thumbnail
        -F factor       Scale factor for the thumbnail, draw downscaled and compare to 1x
        -z              Display generation performance info (don't display thumbnails)
        -o dir          Output result in dir (don't display thumbnails or previews)
        -c contentType  Force the content type used for the documents
        -g generator    Force the generator to use
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

1. Install the QuickLook generator, e.g. `brew install qlcolorcode`{:.highlight}
2. On your terminal, `xattr -cr ~/Library/QuickLook/QLColorCode.qlgenerator`{:.highlight} run (using `sudo` if needed), replacing `QLColorcode` with whatever the name of the QuickLook plugin
3. Reload the QL Generator with `qlmanage -r`{:.highlight}
4. Now refresh the cache `qlmanage -r cache`{:.highlight}
5. Restart Finder by running `killall Finder`{:.highlight}

For those wanting to cut and paste the whole lot:

```sh
brew install qlcolorcode
xattr -cr ~/Library/QuickLook/QLColorCode.qlgenerator
qlmanage -r
qlmanage -r cache
killall Finder
```


## QuickLook Generators I use

- QLStephen - <https://whomwah.github.io/qlstephen/>  
  This Quick Look plug-in allows you to view most text files without specific extensions (README,Makefile etc)

- QLColorCode - <https://github.com/anthonygelibert/QLColorCode>  
  Quick Look plug-in that renders source code with syntax highlighting

- QLMarkdown - <https://github.com/toland/qlmarkdown>  
  QLMarkdown is a simple QuickLook generator for Markdown files

```sh
brew install qlstephen qlcolorcode qlmarkdown
xattr -cr ~/Library/QuickLook/QLMarkdown.qlgenerator 
xattr -cr ~/Library/QuickLook/QLStephen.qlgenerator 
xattr -cr ~/Library/QuickLook/QLColorCode.qlgenerator
qlmanage -r
qlmanage -r cache
```

## Adding support for unknown file types

If there is a file extension that is not being shown by any of your QuickLook extensions, you can easily add them to 
the list of one of the ones I showed above. 

For example, to add `.conf` files to the `QLColorCode` extension do the following:

1. Find an example file of the type that you want to add to QuickLook  
2. Run `mdls -name kMDItemContentType ` followed by the file name so in my case:  
   ```
   mdls -name kMDItemContentType /Users/me/wpa_supplicant.conf
   ```
3. Make note of the output.  In my exmaple this was:  
   ```
   kMDItemContentType = "dyn.ah62d4rv4ge80g55sq2"
   ```
4. Now you need to add the part in quotes to the QL config. So:  
   ```
   nano ~/Library/QuickLook/QLColorCode.qlgenerator/Contents/Info.plist
   ```
   where `QLColorCode` is the QL generator I want to add this file to.  

5. In the editor you just opened, look for three lines that look like this:  
   ```
          </array>
        </dict>
      </array>
   ```
6. Now add a new line before those that includes the part in quotes from step #3, so:  
   `<string>dyn.ah62d4rv4ge80g55sq2</string>`
7. Press `CTRL-X` and then `y` and `Enter` to save the file
8. Run 
   ```
   qlmanage -r
   ```
9.  You may need to restart Finder 
    ```
    killall Finder
    ```

Now you can press space on the new file type and it should open in QuickLook for you. 


