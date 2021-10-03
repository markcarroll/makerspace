---
layout: post
title: Safely connecting a Raspberry Pi to a 3D Printer
date: 2021-10-02 21:54
category: 3dprinting
author: Mark
tags: [octoprint]
summary:
image: /3dprinting/images/raspberry-pi-octoprint/usb_power_blocker.jpeg
description: Safely connect a Raspberry Pi with Octoprint to a 3D Printer such as Creality Ender 4 or Cr-10 with a USB Power Blocker
---

When plugging a Raspberry Pi into a 3D printer, unless the board is specifically designed to be powered by the USB port (like some BigTreeTech boards) the 5V power supply coming across the USB connection can cause damage both to the printer main board and back the other way to the Raspberry Pi. This is particularly noticeable with Creality stock boards on Ender series and CR-10 series printers.

<iframe style="width:120px;height:240px;float:right" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=mwp-14-20&language=en_US&marketplace=amazon&region=US&placement=B092MLT2J3&asins=B092MLT2J3&linkId=25faf20e76e45729e8a1b2fdcc6f40f6&show_border=true&link_opens_in_new_window=true"></iframe>
![-](images/raspberry-pi-octoprint/61UoGdSX26L._AC_SX679_.jpg)

The solution is to use a [power blocker USB adapter](https://amzn.to/3DbzElN). They can be found on [Amazon](https://amzn.to/3DbzElN) for very little money and are well worth the expense.

There are posts tell you to put electrical tape on the 5V line in the USB plug, but that can come off or get stuck in the socket. Using an adapter is the best solution.
