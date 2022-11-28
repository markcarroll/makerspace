---
layout: post
title:  "VSCode keeps asking for SSH key passphrase"
author: mark
categories: [ code ]
tags: [VSCode, macOS, SSH]
image: code/assets/github-ssh-key.png
description: "How to stop VSCode from continually asking for SSH Key passphrase on macOS Ventura"
featuredImage: false
print: false

---

Ever since upgrading my Macs to macOS 13 (Ventura) I have noticed that VSCode keeps asking for the passphrase for the SSH Key associated with my GitHub user account.

I have a separate key file for GitHub instead of using the default `id_rsa` key file. This helps me keep some separation between my default machine key and the one that I use for accessing GitHub, which i can then sync across machines. As is recommended, that key file has a passphrase to access it which is what VSCode keeps asking for every time it tries to check the status of my GitHub repos.  

My GitHub-specific key file is called `github.key` which you will see referenced below. Of course change this to match what you need.

### Persisting the key and pass-phase to macOS KeyChain

What we need to do is add the GitHub specific key file to macOS's `ssh-agent` which is running in the background by default. This is done by using:

```sh
ssh-add ~/.ssh/github.key 
```

This will add the key to the SSH Agent and will need to _ask for the passphrase_ to do so,  however, it will only remain in SSH agent until the next reboot.  That is great, but not really all that helpful.  In order to persist the key and associated passphrase permanently we need to add a flag to the command:

```sh
ssh-add --apple-use-keychain ~/.ssh/github.key 
```

Again this will ask for the passphrase, hopefully for the last time, as it adds the to the SSH Agent and stores the passphrase just like your other passwords in the macOS KeyChain.

### Configuring a separate key file

In case you want to set up a separate key for `git` but have not done so yet, you will need to add the following to the `~/.ssh/config` configuration file:

```ini
Host github.com
	HostName github.com
	IdentityFile ~/.ssh/github.key
	User [your_github_username]
```

This tells `git` which SSH Key file to use for accessing `github.com`.

This took me quite a while to figure out so I hope this helps someone.
