---
layout: post
title: Running klipper on an Ender 6
author: mark
tags: [Klipper]
description: Here are my notes and steps for installing and running klipper on an Ender 6
image: /3dprinting/images/klipper-ender-6/ender6-klipper.jpg
toc: true
---

## Klipper Tips

### Config Files

You can view my current Ender 6 config at my Github repo: [klipper_ender6](https://github.com/markcarroll/klipper_ender6)

Here is a [sample one](../files/klipper-ender-6/ender6_printer.cfg) that I snapshotted early on.

### Bed leveling

#### Cacluate Bed Mesh

Run the following commands:

1. `BED_MESH_CALIBRATE`
2. `BED_MESH_PROFILE SAVE=name`
3. `SAVE_CONFIG`

Only run #2 and #3 above if you want the mesh to persist after reboot.

#### Bed Visualizer

To see bed mesh in Octoprint's Bed Visualizer, go to the `Bed Visualizer` page and click on the cog in the lower right. In the gcode box put:

```text
M140 S65                    ; set bed temp to 65C
G28                         ; home the axis while the bed is heating
M190 S65                    ; (optional) wait for the bed to get up to temperature
BED_MESH_CALIBRATE          ; start calibration
@BEDLEVELVISUALIZER         ; tell Octoprint plugin to listen to result
BED_MESH_OUTPUT PGP=0       ; report the mesh to Octoprint
BED_MESH_PROFILE SAVE=mesh  ; save the profile to named profile `mesh`
```

I also added a shortcut button on the bed visualizer page to save the config.

1. While still in the Bed Visualizer settings page click on `Commands` tab.
2. Create a new button, name it "Save Config"
3. Set the gcode to `SAVE_CONFIG`
4. Close the input dialog

Now save the settings page.

## Updating the Ender 6 built in LCD screen to support Klipper

### Install the klipper source

```bash
git clone https://github.com/Klipper3d/klipper
cd klipper
git remote add desuuuu-klipper https://github.com/Desuuuu/klipper.git
git fetch desuuuu-klipper
git checkout desuuuu-klipper/master
make menuconfig
```

For the stock Ender 6 main board you need the following settings:

![Stock Ender 6 klipper settings](images/klipper-ender-6/ender 6 stock klipper.png)

For the BigTreeTech SKR 2 board (such as the one in my Ender 6) you need:

## Installing Klipper on an Ender 6

The steps below are for installing *klipper* on an Ender 6 that has been upgraded with the following list of mods:

1. BigTreeTech SKR 2 main board
2. Biqu H2 Extruder & hot end
3. Bimetallic heat break for Biqu H2
4. Custom enclosure for printing ABS

### Installation steps

On your Raspberry Pi (or other machine if you prefer) we need to install the klipper source (if you have not already) and then add the `desuuuu` repository that specifically supports the T5UID display of the Ender 6.

To initially install klipper on Raspberry Pi:

```sh
git clone https://github.com/Klipper3d/klipper
./klipper/scripts/install-octopi.sh
```

To fetch the forked version of klipper that works with T5UID display on an Ender 6:

```sh
git remote add desuuuu-klipper https://github.com/Desuuuu/klipper.git
git fetch desuuuu-klipper
git checkout desuuuu-klipper/master
```

### Build the firmware for the motherboard

To compile the micro-controller code, start by running these commands on the Raspberry Pi:

```sh
cd ~/klipper/
make menuconfig
```

For the _Stock Ender 6 main board_ set these to:

![Stock Ender 6 klipper settings](images/klipper-ender-6/ender 6 stock klipper.png)

For the _BigTreeTech SKR 2_ in an _Ender 6_ set these as follows:

```txt
[*] Enable extra low-level configuration options
    Micro-controller Architecture (STMicroelectronics STM32)  --->
    Processor model (STM32F407)  --->
    Bootloader offset (32KiB bootloader)  --->
    Clock Reference (8 MHz crystal)  --->
    Communication interface (USB (on PA11/PA12))  --->
[*] Enable DGUS T5UID1 screen
        Screen Serial Port (USART1)  --->
    USB ids  --->
[ ] Specify a custom step pulse duration
()  GPIO pins to set at micro-controller startup
```
{: style="background-color:#C0BFC0;font-weight:700"}

Now build the firmware file:

```bash
make
```

Now copy the `out/klipper.bin` file to the SD card on your computer. Best way to do this is from your Mac:

```bash
scp pi@octopi.local:/home/pi/klipper/out/klipper.bin /Volumes/SD\ FAT\ 4GB/firmware.bin
```

Then eject the SD Card with

```bash
diskutil eject
```

Now insert the SD card into the printer's SD card slot and turn it on. The firmware will install and klipper will be ready and waiting for the Raspberry Pi to connect.

### Update the LCD display firmware

The firmware on the Ender 6 LCD display also needs updating to support klipper.

Follow the instructions found here: <https://github.com/Desuuuu/DGUS-reloaded-Klipper>

### Update for the new DGUS_display branch from _desuuuu_

There is an updated version of the DGUS display code from _desuuuu_ that is slightly different that the previous process.

GitHub user [_desuuuu_](https://github.com/Desuuuu) has a new repo for a much more customizable LCD firmware here <https://github.com/Desuuuu/DGUSPrinterMenu>.

To use it we need to use a different branch of their klipper repo, so the steps above
are now slightly different.

If you have not already installed klipper from the earlier steps, these are still the same, however you can skip them if you already done this part.

```sh
git clone https://github.com/Klipper3d/klipper
cd klipper
git remote add desuuuu-klipper https://github.com/Desuuuu/klipper.git
git fetch desuuuu-klipper
```

Now in the `klipper` directory, the new part:

```sh
git checkout desuuuu-klipper/dgus-display
make menuconfig
```

Make sure everything looks like this:

![Klipper screen](images/klipper-ender-6/Ender 6 klipper 3.png)

Now run

```sh
make
```

Copy the `out/klipper.bin` file to the SD card as before (see above) and flash it to your printer.

Next follow the instructions for flashing the display firmware here: <https://github.com/Desuuuu/DGUSPrinterMenu/wiki/Flashing-the-firmware>

### Service control

To start, stop or restart klipper service on the Raspberry Pi command line:

```sh
sudo service klipper start|stop|restart
```
