---
layout: post
title: Installing Klipper on Sunlu S8 with SKR 2
date: 2021-09-18 16:33
category: 3dprinting
author: mark
tags: [Sunlu S8]
description:
---

This walkthough is really just notes for me and anyone else that wants to install _klipper_ on a Sunlu S8.

Within days of purchasing a Sunlu S8 Plus (actually branded Jay S8+) I realized the noisy steppers needed to be replaced, so I switched out the main board to a [BigTreeTech SKR 2 motherboard](https://amzn.to/2Xu85Es) with silent [TMC 2209 stepper drivers](https://amzn.to/3tRzsEE). I bought this board over the slightly cheaper SKR Mini because I wanted the extra 5th stepper driver for the second z-axis motor so I can do software z-axis syncing.

I also bought the BigTreeTech TFT35 E3 V3.0 LCD so I will be trying to get that working too. Amazon (<i class="fab fa-amazon"></i>) has a good bundle on all three together which saves about $20 at time of writing: [SKR 2 + TFT35 E3 V3.0 + TMC2209⨉5](https://amzn.to/2Xxtj4g).

## Requirements / Setup

- Sunlu S8 / S8+ (or Jayo equivalent)
- BigTreeTech SKR 2 motherboard
- BigTreeTech TMC 2209 stepper drivers x 5
- BigTreeTech TFT35 E3 V3.0 LCD display (optional)
- Raspberry Pi running Octoprint

## Installing Klipper

### Prepare Raspberry Pi for klipper

OK, let's get started. First you need to `ssh` into your Raspberry Pi. In my case mine is called `octpopi`:

```sh
ssh pi@octopi.local
```

### Update the Raspberry Pi's Software

Now, since Raspberry pi images seem to have been updated since the Octopi version that I have on both of my devices, you do need to run an upgrade command first:

```sh
sudo apt-get update --allow-releaseinfo-change
```

The last part is important since without it you might get this error:

```sh
E: Repository 'http://raspbian.raspberrypi.org/raspbian buster InRelease' changed its 'Suite' value from 'stable' to 'oldstable'
```

### Install Klipper onto the Pi

First we need to bring the klipper code locally from the github repository:

```sh
git clone https://github.com/KevinOConnor/klipper
```

Then run the install script

```sh
./klipper/scripts/install-octopi.sh
```

This may take a few minutes.

## Flashing the Board

### Configure Klipper for your board

Let's open up the config tool and get it configured for our board

```sh
cd ~/klipper/
make menuconfig
```

The SKR 2 has a `STM32F407VGT6` so we need to set the options up as follows:

    [ ] Enable extra low-level configuration options
        Micro-controller Architecture (STMicroelectronics STM32)  --->
        Processor model (STM32F407)  --->
        Bootloader offset (32KiB bootloader)  --->
        Communication interface (USB (on PA11/PA12))  --->

Once you have these set, hit `Q` to **save and exit**.

Now we build the microcontroller firmware with:

```sh
make
```

When this completes you should see it end with

```sh
  Creating hex file out/klipper.bin
```

This is the file we need to install on the printer's motherboard so that it can communicate with the Raspberry Pi over the USB cable. We need to copy this off the Raspberry Pi and onto the SD card that you are going to insert into the SKR 2 board to reflash the firmware.

I am using a Mac so I do it like this, if you have a different machine the process may be different.

Before leaving the Pi's `ssh` session you can start the `klipper` service now:

```sh
sudo service klipper start
exit
```

Then exit the ssh session on your Rasperry Pi with `exit`. Now back on your Mac run `scp` to copy the `klipper.bin` file locally. We will rename it as we copy it so it's the right name for the flash process to work (dont forget to change the machine name from `octopi.local` to whatever yours is called):

```sh
scp pi@octopi.local:/home/pi/klipper/out/klipper.bin ~/Downloads/firmware.bin
```

Insert the SD card into your machine and drag `firmware.bin` from your `Downloads` folder onto the SD card. Don't forget to safely eject the card once this is done.

Insert the SD card into the SD slot on the SKR 2 and turn on the machine. Don't worry nothing is going to happen yet other than a blank screen.

## Configuring Klipper

At this point klipper does not know much about our machine, so we need to teach it what pins on our SKR 2 board do what. This will depend slightly on how you connected up your cables. Here is how I connected mine:

- Main board fan: FAN0
- Hot end fan: FAN1
- Part cooling fan: FAN2
- Steppers as follows:
  - x stepper => XM
  - y stepper => YM
  - z left stepper => ZMA
  - extruder => E0M
  - z right stepper => E1M

### Install Klipper plugin on OctoPrint

There any many ways to edit your `printer.cfg` file that tells klipper all about your printer, but I like the OctoPrint plugin that allows me to edit it in place theought the UI. Head to your Octoprint install on your Raspberry Pi, in my case http://octopi.local

Go to the setup page, click on Plugin Manager and install the OctoKlipper plugin.

You will now need to restart OctoPrint

### Editing the config

Go to the new OKlipper tab on Octoprint and click on `Open Klipper Config`.

Your config file will be empty right now so click on the black line next to the number one (`1`) and paste

# DONT FORGET TO ADD MISSING PART FROM KLIPPER DOCS

`nano ~/printer.cfg`
add in the mcu section
`ls /dev/serial/by-id/*`

```
[mcu]
serial: /dev/serial/by-id/usb-1a86_USB2.0-Serial-if00-port0
```
