---
layout: post
title:  "Install PiHole on Unifi Dream Machine (UDM)"
author: mark
categories: [ code ]
tags: [Unifi, UDM, PiHole]
image: code/assets/Vortex-R.png
description: "My steps to getting PiHole to block ads for all devices on my network using only my UDM (No Raspberry Pi needed)"
print: false
featuredImage: false
---

I am not a networking expert, but I do have a Unifi Dream Machine and figured that the CPU was plenty powerful enough to run PiHole to block ads on my network without needed an extra Raspberry Pi (since they are so hard to find these days).

To that end, I found instructions on how to do this across two repos.  The below is a collection of the steps I took from each of their sets of instructions, mostly so I can remember how to do it again.

1. <https://github.com/unifi-utilities/unifios-utilities>
2. <https://github.com/unifi-utilities/unifios-utilities/tree/main/run-pihole>

So here goes...

## Enable SSH

1. Make sure SSH is enabled in your UDM setup screen.

2. Set an SSH password that we will use in the next step.

## Log in to your UDM terminal

From your command line execute `ssh` as shown below. Note the password will be the one you created earlier.

```sh
~  ssh root@unifi.local
Welcome to UbiOS

By logging in, accessing, or using the Ubiquiti product, you
acknowledge that you have read and understood the Ubiquiti
License Agreement and agree to be bound by its terms.

root@unifi.localʼs password: <enter your SSH password here>
  ___ ___      .__________.__
 |   |   |____ |__\_  ____/__|
 |   |   /    \|  ||  __) |  |   (c) 2010-2022
 |   |  |   |  \  ||  \   |  |   Ubiquiti Inc.
 |______|___|  /__||__/   |__|
            |_/                  http://www.ui.com

      Welcome to UniFi Dream Machine!

********************************* NOTICE **********************************
* By logging in to, accessing, or using any Ubiquiti product, you are     *
* signifying that you have read our Terms of Service (ToS) and End User   *
* License Agreement (EULA), understand their terms, and agree to be       *
* fully bound to them. The use of CLI (Command Line Interface) can        *
* potentially harm Ubiquiti devices and result in lost access to them and *
* their data. By proceeding, you acknowledge that the use of CLI to       *
* modify device(s) outside of their normal operational scope, or in any   *
* manner inconsistent with the ToS or EULA, will permanently and          *
* irrevocably void any applicable warranty.                               *
***************************************************************************

#
```

## Install the boot scripts

Now run the install script from the [`unifios-utilities`](https://github.com/unifi-utilities/unifios-utilities/blob/main/on-boot-script/README.md) repo:

```sh
curl -fsL "https://raw.githubusercontent.com/unifi-utilities/unifios-utilities/HEAD/on-boot-script/remote_install.sh" | /bin/sh`

  _   _ ___  __  __   ___           _
 | | | |   \|  \/  | | _ ) ___  ___| |_
 | |_| | |) | |\/| | | _ \/ _ \/ _ \  _|
  \___/|___/|_|  |_| |___/\___/\___/\__|

 Execute any script when your udm system
 starts.

UDM/Pro detected, installing on-boot script...
Downloading UDM boot package...

Installing UDM boot package...
Selecting previously unselected package udm-boot.
(Reading database ... 30109 files and directories currently installed.)
Preparing to unpack /tmp/udm-boot_1.0.5_all.deb ...
Unpacking udm-boot (1.0.5) ...
Setting up udm-boot (1.0.5) ...
Created symlink /etc/systemd/system/multi-user.target.wants/udm-boot.service → /lib/systemd/system/udm-boot.service.
#-> ubnt-dpkg-cache install
udm-boot: action=install, package=/data/dpkg-cache/stretch/packages/udm-boot_1.0.5_all.deb mark=manual
<-# ubnt-dpkg-cache install

UDM Boot Script installed

Downloading CNI plugins script...
CNI plugins script installed
Executing CNI plugins script...
Downloading https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-arm64-v1.1.1.tgz.sha256
Downloading https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-arm64-v1.1.1.tgz
Pouring /mnt/data/.cache/cni-plugins/cni-plugins-linux-arm64-v1.1.1.tgz

Downloading CNI bridge script...
CNI bridge script installed
Executing CNI bridge script...
/mnt/data/on_boot.d/06-cni-bridge.sh

On boot script installation finished

You can now place your scripts in `/mnt/data/on_boot.d`

#
```

## Install SSH key for password-less login (optional)

Create a file called `/mnt/data/on_boot.d/settings/ssh/authorized_keys` and paste in your SSH **Public Key** from your local machine.

Now crate a file at `/mnt/data/on_boot.d/15-add-root-ssh-keys.sh`  and copy in the content from [15-add-root-ssh-keys.sh](https://github.com/unifi-utilities/unifios-utilities/blob/main/on-boot-script/examples/udm-files/on_boot.d/15-add-root-ssh-keys.sh).

Give the script execute permissions and then execute the script:

```sh
chmod ugo+x /mnt/data/on_boot.d/15-add-root-ssh-keys.sh
/mnt/data/on_boot.d/15-add-root-ssh-keys.sh
```

Now you can connect to your UDM directly with `ssh root@unifi.local` and you will not need a password.

## Install PiHole container

Install PiHole using the instructions here: <https://github.com/unifi-utilities/unifios-utilities/tree/main/run-pihole>

### Configuration files and scripts

These are the settings I used. You may want to do things differently.

```sh
 vi /mnt/data/podman/cni/20-dns.conflist 
```

Paste in your amended content as below:

```json
{
  "cniVersion": "0.4.0",
  "name": "dns",
  "plugins": [
    {
      "type": "macvlan",
      "mode": "bridge",
      "master": "br5",
      "mac": "00:1c:b4:01:23:45",
      "ipam": {
        "type": "static",
        "addresses": [
          {
            "address": "10.0.5.3/24",
            "gateway": "10.0.5.1"
          }
        ],
        "routes": [
          {"dst": "0.0.0.0/0"}
        ]
      }
    }
  ]
}
```

Then make it executable and run it. You can verify it worked by running the last command and verifying the output matches what you typed in.

```sh
 chmod +x /mnt/data/podman/cni/20-dns.conflist
 cp /mnt/data/podman/cni/20-dns.conflist /etc/cni/net.d/dns.conflist
 podman network inspect dns
```

I followed the steps as described, only changing the MAC address in the `20-dns.conflist` as suggested. This all seemed to work.

Next set up the DNS script that you will copy from [here](https://github.com/unifi-utilities/unifios-utilities/blob/main/dns-common/on_boot.d/10-dns.sh) only changing the values if you modified them in the previous step.

```sh
vi /mnt/data/on_boot.d/10-dns.sh
chmod +x /mnt/data/on_boot.d/10-dns.sh
/mnt/data/on_boot.d/10-dns.sh
```

### Create directories for persistent Pi-hole configuration

```sh
mkdir -p /mnt/data/etc-pihole
mkdir -p /mnt/data/pihole/etc-dnsmasq.d
```

### Create the pihole container

I set mine up a little differently than the `README.md` since I wanted to make sure local machine name resolution was working properly and this setup worked for me in the past.

```sh
podman run -d --network dns --restart always --name pihole -e TZ="America/Los Angeles" --cap-add=NET_ADMIN -v "/mnt/data/etc-pihole/:/etc/pihole/" -v "/mnt/data/pihole/etc-dnsmasq.d/:/etc/dnsmasq.d/" --dns=127.0.0.1 --hostname pi.hole -e VIRTUAL_HOST="pi.hole" -e PROXY_LOCATION="pi.hole" -e FTLCONF_REPLY_ADDR4="10.0.5.3" -e IPv6="False" -e DNS_FQDN_REQUIRED=true -e DNS_BOGUS_PRIV=false -e DNSSEC=false -e REV_SERVER=true -e REV_SERVER_CIDR=10.0.1.0/24 -e REV_SERVER_TARGET=10.0.1.1 -e REV_SERVER_DOMAIN= -e PIHOLE_DNS_1=10.0.1.1 pihole/pihole:latest
```

### Set the admin password

```sh
podman exec -it pihole pihole -a -p YOURNEWPASSHERE
```

Now just follow the instructions in the README

- Update your DNS Servers to 10.0.5.3 for each of your Networks (UDM GUI / Networks / Advanced / DHCP Name Server)
- Access the pihole web interface like you would normally, e.g. <http://10.0.5.3> or <http://pi.hole>

## Updating PiHole

Updating the docker container is different than the regular Raspberry Pi install.  Since it is a container you have to delete it and re-run the `podman` command. To do this, create a script:

```sh
vi /mnt/data/scripts/upd_pihole.sh
chmod +x /mnt/data/scripts/upd_pihole.sh
```

The contents of the script should be:

```sh
IMAGE=pihole/pihole:latest

podman pull $IMAGE
podman stop pihole
podman rm pihole
podman run -d --network dns --restart always --name pihole -e TZ="America/Los Angeles" --cap-add=NET_ADMIN -v "/mnt/data/etc-pihole/:/etc/pihole/" -v "/mnt/data/pihole/etc-dnsmasq.d/:/etc/dnsmasq.d/" --dns=127.0.0.1 --dns=10.0.1.1 --hostname pi.hole -e VIRTUAL_HOST="pi.hole" -e PROXY_LOCATION="pi.hole" -e FTLCONF_REPLY_ADDR4="10.0.5.3" -e IPv6="False" pihole/pihole:latest
```

where the last command is the one you used to create the container.
