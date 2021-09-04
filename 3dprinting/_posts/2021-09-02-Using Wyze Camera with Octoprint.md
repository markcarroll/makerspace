---
layout: post
title: Using a Wyze Camera with Octoprint
date: 2021-09-02 11:46
category: 3dprinting
author: Mark
tags: [3dprinting, octoprint]
image: /3dprinting/images/Using-Wyze-Cam-with-Octoprint/wyzecam_v2.jpg
summary:
---

Wyze Cam V2's are awesome web cameras that could be found for very little money for which they include a surprising amount of functionality. I bought a few of the [Wzye Cam V2](https://amzn.to/2WOhJBK)'s for around $20 each and scattered them around the house. They are great it you want to monitor something and don't want to fiddle around with anything more complicated. They even have motion capture and event recording included in the Wyze app.

> _**Update**: it looks like Wyze released a V3 camera which has not yet been hacked, so note, this only works on the V2 for now._

### Parts List

- Wyze Cam V2 [_(Amazon)_](https://amzn.to/2WOhJBK)
- Raspberry Pi running Octoprint [_(Amazon)_](https://amzn.to/3gToJEs)
- Micro SD Card to flash the camera's firmware [_(Amazon)_](https://amzn.to/3yLxk2k)

### Files

- New firmware for Wyze cam from [OpenMiko's GitHub page](https://github.com/openmiko/openmiko/releases) - I used <a href='https://github.com/openmiko/openmiko/releases/download/v0.0.25/openmiko_firmware.bin' download>v0.0.25 <i class='fa fa-download'></i></a>
- WiFi configuration file `wpa_supplicant.conf` - sample <a href='files/Using-Wyze-Cam-with-Octoprint/wpa_supplicant.conf' download='wpa_supplicant.conf'>here <i class='fa fa-download'></i></a>

### Instructions

1. Download the firmware listed above in the [Files](#files) section
2. Rename the `openmiko_firmware.bin` to **`demo.bin`** and copy to the root of the microSD card
3. On the microSD card make the following directories: `/config/overlay/etc` and inside that create a text file called `wpa_supplicant.conf` or download <a href='files/Using-Wyze-Cam-with-Octoprint/wpa_supplicant.conf' download='wpa_supplicant.conf'>this sample <i class='fa fa-download'></i></a>
4. Edit `wpa_supplicant.conf` and insert your wifi name and password and save it
5. Power off the camera and insert the microSD card with the `demo.bin` file on it
6. Hold the setup button, plug in your USB cable, keep holding the setup button for 1-2 seconds until the light is solid blue, then release the button
7. After about 30 seconds you should get a flashing yellow LED which indicates the camera is working
8. Now the hard part for some. You need to find the IP address of the camera on your local network. You will need to check your router to find the camera's MAC address (it is usually on a sticker on the camera)
9. In Octoprint go to settings and choose the Webcam settings and set the stream URL to `http://<cam-ip-address-here>:8080?action=stream` (see example in screenshot) ![Octoprint](images/Using-Wyze-Cam-with-Octoprint/Using-Wyze-Cam-with-Octoprint-4.png){: .screenshot style="margin-top:10px;margin-bottom:0px" }
10. Then further down set the shapshot URL to `http://<cam-ip-address-here>:8080/?action=snapshot` (Note: remove `webcam/` from the path) ![Octoprint](images/Using-Wyze-Cam-with-Octoprint/Using-Wyze-Cam-with-Octoprint-3.png){: .screenshot style="margin-top:10px;margin-bottom:0px;max-width: 550px;" }

And that should be it.

For more information, check out the OpenMiko GitHub page: [https://github.com/openmiko/openmiko](https://github.com/openmiko/openmiko)
