---
layout: post
title: Buck Converter Box
date: 2021-09-08 21:33
category: 3dprinting
author: mark
tags: [Ender 6, STL, Models, Prints]
image: /3dprinting/images/buck-converter-box/buck converter box.jpg
description: STL for a Simple box with a snap-fit lid for a HiLetGo DC to DC Buck Converter
---

This is a simple box with a snap-fit lid for a [HiLetGo DC to DC Buck Converter](https://amzn.to/3BRNHw4) to allow it to fit into a 3D printer case without coming in contact with the metal surround.

In my case I wanted to run a [12V Gelid 40mm silent fan](https://amzn.to/3E0vgHq) off a [Ender 6's](https://amzn.to/3zVQq7e) 24V power supply. The Gelid fan is so much quieter than the stock fan this was absolutely worth the small amount of effort required. At first the idea of having to use a buck converter made me hesitate. I had not done any soldering in years and had never used a buck converter before. These ones I found on Amazon were great though, no soldering needed and the display allowed for no ambiguity about the voltage being passed through. Also, at only around $4 each it seemed like it was worth a try.

However, I needed a safe way to mount the buck converter so this box is what I came up with. The lid is a tight snap fit so make sure you have your printer well tuned (or maybe print the list at 99%). The window in the lid allows you to see the LEDs on the buck converter while it is on.

![Buck converter box](/3dprinting/images/buck-converter-box/buck converter box 2.png)
![Buck converter box](/3dprinting/images/buck-converter-box/buck converter box 3.png)

  <iframe style="width:120px;height:240px;float:right" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=mwp-14-20&language=en_US&marketplace=amazon&region=US&placement=B00BF3S83C&asins=B00BF3S83C&linkId=a9d354e99a26ba872450ec9ee0752d36&show_border=true&link_opens_in_new_window=true"></iframe>
  <iframe style="width:120px;height:240px;float:right" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=mwp-14-20&language=en_US&marketplace=amazon&region=US&placement=B00LSEBYHU&asins=B00LSEBYHU&linkId=4735e25ee0262a5704efd8f9b5430e87&show_border=true&link_opens_in_new_window=true"></iframe>

### Parts List

- HiLetgo LM2596 Adjustable DC-DC Step Down Buck Power Convert Module 4.0-40V Input to 1.25-37V Output with LED Voltmeter Display [_(Amazon)_](https://amzn.to/3BRNHw4)
- (Optional) 12V Gelid 40mm silent fan [_(Amazon)_](https://amzn.to/3E0vgHq)

### Files

- [Buck Converter Box STL file <i class='fa fa-download'></i>](files/buck-converter-box/Buck Converter Box v3.stl)

### Print Settings

|**Printer:**| Creality Ender 6|
|**Slicer:**| Cura|
|**Material:**| Overture PLA+|
|**Resolution:**| 0.2 mm with a 0.4mm nozzle|
|**Wall Lines:**| 4|
|**Supports:**| No|
|**Infill:**| 15% Cubic |
{:.print-settings}

### Instructions

This is pretty straight forward.

#### Set the Voltage before assembling

Just make sure you have set the buck converter to the correct voltage before wiring it up to the fan. The easiest way to do this is to connect the input side up to the power supply and tune the adjustment screw with a small flat head screwdriver. The output voltage will show on the display. There is a button on the board to toggle the display between input and output voltage though, so make sure you have it set to the output voltage when tuning it. Set it to 12V.

#### Assemble and wire the box

1. Print the box and the case
2. Insert the buck converter into the case and screw to the box with M3x4mm screws (M3x6mm should fit)
3. Thread the wires through the slots and screw into the terminals on the buck converter
4. Snap the lid in place.
5. Mount in the case with some double sided tape

That's it. This is what mine looks like:

![Ender 6 guts](/3dprinting/images/buck-converter-box/ender-6-guts.jpg){: style="max-width:800px" }

Happy Printing.

#### [Post a comment](https://www.reddit.com/r/MarksMakerSpace/comments/pkrjpe/buck_converter_box/)
