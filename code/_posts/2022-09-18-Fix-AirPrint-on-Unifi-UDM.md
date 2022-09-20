---
layout: post
title:  "Fixing Unifi AirPrint problems"
author: mark
categories: [ code ]
tags: [Unifi, AirPrint, Network]
image: code/assets/ui-logo.png
description: "Trying to find a solution to AirPrint printers keep disappearing on Unifi network"
featuredImage: false
print: false
---

I recently upgraded my [Unifi Dream Machine](https://amzn.to/3LqRaHL) network by adding a couple of the new [U6-LR Access Points](https://amzn.to/3f0TIQK). These add Wifi6 support and are powered by POE to keep things clean and simple.

The Wifi6 APs are working well, however We have been having problems getting  AirPrint to work on my phone and iPad.  I am not a router expert and have tried a lot of different solutions posted online. Nothing seemed to work for long until I came across a proposed solution in a [thread on the Unifi Community Forum](https://community.ui.com/questions/Unifi-Settings-for-AirPrint-Printers-work-only-for-a-few-minutes/375e43ed-5995-43ba-886b-df846165bfaf#answer/b0ce505c-1a02-4a99-bfc1-4f5e93bbdc3b).

It needed some updating for the new UI so here it what it converts to:

> * Networks → Enable `IGMP snooping`
> * WiFi → Click on your SSID → Multicast Management `Show Options`
>   * Enable `Multicast enhancement`
>   * Disable `Multicast and Broadcast Control`
> * Profiles / Port and IP Groups / Create New Group
>   * Profile Name: `Airprint`
>   * Type: `Port Group`
>   * Port - add each of the following:
>     * `5353` (Apple AirPlay/Bonjour/AirPrint/Communications port - MAIN UDP AirPrint port)
>     * `6002` (Apple AirPlay/Bonjour/AirPrint/Communications port)
>     * `7000` (Apple AirPlay/Bonjour/AirPrint/Communications port)
>     * `49152-65535` (A large grouping to cover what Sonos chaos can cause Bonjour to try other ports - most will not need this range)
>   * Click `Apply Changes`
> * Firewall & Security → Firewall Rules → click "Create New Rule"
>   * Name it
>   * Rule Applied: choose `After predefined rules`
>   * Action: `Accept`
>   * IPv4 Protocol: `All`
>   * Source
>   * Source Type: `Port/IP Group`
>     * IPv4 Address Group: `Any`
>     * Port Group: select `AirPrint` or the name of the one you created above
>     * MAC address: leave empty
>   * Destination
>     * Destination Type: `Port/IP Group`
>     <!-- * Destination Type: Enable IP Address -->
>     * IPv4 Address Group: `Any`
>     <!-- * IPv4 Address: enter in the Wired or Wireless LAN of the printer on your network -->
>   * Advanced: set to manual
>     * IPsec: `Don't match on IPsec packets`
>   * Click `Apply Changes`

I have tried removing some of these settings and it is still working, so I will continue to narrow down what the minimal setting change is.  I suspect just setting port `5353` is enough. I am running tests... 

Your mileage may vary. As I said before, I am not a network expert.

Good luck!
