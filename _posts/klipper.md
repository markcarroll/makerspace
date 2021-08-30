# klipper notes for Ender 6

## Raspberry Pi Commands

### Installing Klipper

To initially install klipper on Raspberry Pi:

```sh
git clone https://github.com/KevinOConnor/klipper
./klipper/scripts/install-octopi.sh
```

To fetch the forked version of klipper that works with T5UID display on Ender 6:

```sh
git remote add desuuuuklipper https://github.com/Desuuuu/klipper.git
git fetch desuuuuklipper
git checkout desuuuuklipper/master
```

### Build the firmware for the motherboard

To compile the micro-controller code, start by running these commands on the Raspberry Pi:

```sh
cd ~/klipper/
make menuconfig
```

For the _BigTreeTech SKR 2_ in an _Ender 6_ set these as follows:

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

Now build the firmware file:

```sh
make
```

Now copy the `out/klipper.bin` file to the SD card on your computer. Best way to do this is from your Mac:

```sh
scp pi@octopi.local:/home/pi/klipper/out/klipper.bin /Volumes/SD\ FAT\ 4GB/firmware.bin
```

Then eject the SD Card with

```sh
diskutil eject
```

### Service control

To start, stop or restart klipper service on the Raspberry Pi command line:

```sh
sudo service klipper start|stop|restart
```
