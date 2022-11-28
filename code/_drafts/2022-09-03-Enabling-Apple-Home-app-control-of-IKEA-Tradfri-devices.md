---
layout: post
title:  "Enabling Apple Home app control of IKEA Tradfri devices"
author: mark
categories: [ code ]
tags: [Apple, HomeKit, HomeBridge, Tradfri]
image: assets/images/5.jpg
description: "These are my notes on how to add IKEA Tradfri devices into HomeKit using Homebridge and Zigbee2MQTT"
print: false
---

After recently installing some IKEA Tradfri motorized blinds, I wanted to 
control them from my iPhone in the Home app along with the rest of my house. 

Parts I used:

1. [Raspberry Pi 4B](https://amzn.to/3eljjDM)
2. IKEA Tradfri blinds
3. [Sonoff Zigbee Adapter](https://amzn.to/3TAIfYd)

Components needed:

1. HomeBridge - See the [HomeBridge Wiki](https://github.com/homebridge/homebridge/wiki) for more details
2. [HomeBridge z2m plugin](https://www.npmjs.com/package/homebridge-z2m)
I already had HomeBridge up and running on a Raspberry Pi 4B. If you do not have HomeBridge working yet see the [HomeBridge Wiki](https://github.com/homebridge/homebridge/wiki) for how to get started.

3. MQTT  
Next we need to install an MQTT Broker package - Mosquito is a common one. Follow [this setup](https://randomnerdtutorials.com/how-to-install-mosquitto-broker-on-raspberry-pi/) to get that installed.

4. Zigbee2MQTT  
First make sure your USB Zigbee adapter is plugged in to your Raspberry Pi and you have restarted the RPi. Next, install [Zigbee2MQTT](https://www.zigbee2mqtt.io/guide/installation/01_linux.html#installing)
When you follow the set up script it suggests adding the web UI, however the default port is likely already used by your HomeBridge installation, so instead of:

```yml
frontend: true 
```

instead, set it to:

```yml
frontend:
  port: 8081
```

Now instead of starting the server through `npm start` we want to set it up to run as a system service, so follow the instructions [for that](https://www.zigbee2mqtt.io/guide/installation/01_linux.html#optional-running-as-a-daemon-with-systemctl). However, note the advice about running on a Raspberry Pi with an SD card (which mine is) and turn off logging by changing `StandardOutput` in the service file to:

```ini
StandardOutput=null
```

Now start the service: `sudo systemctl start zigbee2mqtt`
and verify it works: `systemctl status zigbee2mqtt.service`

You should be able to navigate in your browser to `http://rpi:8081` replacing `rpi` with the IP Address or network name of your Raspberry Pi.

Pairing the blinds

The various instructions I found on the internet did not work and caused me hours of frustration. Here are the steps that worked for me. 

1. Install your blinds.
2. Plug one of the signal repeaters that came with your blinds into an outlet in the same room as the blinds. This is important.
3. Pair the repeater you just plugged in by putting a pin in the hole on the side of the repeater for 5 seconds.
4. On the Zigbee2MQTT web interface (referred to as Z2M from here on out) watch for the repeater to join the network. It should appear with a spinner next to it until it has completed joining. At this point I suggest renaming the repeater so you know which one it is. 
5. Now in Z2M you need to set "Disable Join" for all your devices.  You can do this from the dropdown bar in the top right of the nav bar. Select "Disable Join (All)" and then click it. 
6. Now you can drop down that same list and choose "Enable Join" for the IKEA signal repeater next to your blinds - you should now see a countdown timer next to the repeater.
7. On the first blind hold down both the up and down buttons on the blind for 5 seconds until the light comes on, then release.
8. The light on the blinds should pulse for a while until the signal repeater sees the blind and the blind joins the network through the repeater.
9. Rename the blind in Z2M to something more memorable than the default name.
10. Repeat steps 8 and 9 for each blind in the room. 
11. 