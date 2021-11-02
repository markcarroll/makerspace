---
layout: post
title:  "Ender 6 Extruder Relocation"
author: mark
categories: [ 3dprinting ]
tags: [Ender 6, Extruder]
image: /3dprinting/images/ender6-extruder-move/IMG_4008.jpeg
description: "Upgrading an Ender 6 with an BIQU H2 Direct Drive Extruder"
print: false
---


The Ender 6 is a great printer in many aspects, but one thing it has always been troubled with is stringing. The original location of the Ender 6 extruder motor is half way down the right hand of the frame. This design means a very long Bowden tube that results in terrible stringing and the need for fairly extreme retractions that still leave a less than perfect print.


### Solution: Move the Extruder

#### Parts List

<div class="float-sm-right d-none d-sm-block">
<iframe style="width:120px;height:240px" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=thingiver-20&language=en_US&marketplace=amazon&region=US&placement=B071KBVZVV&asins=B071KBVZVV&linkId=a20c23557495cea2216fffab003f220c&show_border=true&link_opens_in_new_window=true"></iframe>
<iframe style="width:120px;height:240px" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=thingiver-20&language=en_US&marketplace=amazon&region=US&placement=B07Z4YH6NP&asins=B07Z4YH6NP&linkId=eace030bcd57d72a0d243857f979b755&show_border=true&link_opens_in_new_window=true"></iframe>
</div>

Extruder Mount:  
{:.mb-0}

- (2) M4x10mm socket cap screws  
- (2) M4 t-slot nuts

Filament Guide:
{:.mb-0}

- (2) M4x10mm socket cap screws
- (2) M4 t-slot nuts

If you don't have a bunch of these on stock I highly recommend getting yourself a couple of very inexpensive kits. These are some examples:
{:.mb-0}

- [M2,3,4 Screw Set](https://amzn.to/2ZqHitO)
- [T Slot Nut Set](https://amzn.to/3pLfqfc)

#### Instructions

The way to reduce stringing is to shorten the Bowden tube.  Pushing and pulling a flexible filament through a flexile tube is never going to be as exact as we would like.  So shorterning the tube should lessen the negative effects.  The best way to do that without buying any new parts is to move the extuder closer to the hot end.  

As it happens the Ender 6 design has a perfect spot for the extruder that seems like it was almost made for this change.

##### 1. Print Parts

First **_before you disassemble the printer_** you will need to print these three items:  
   ![Extruder motor spacer mount](images/ender6-extruder-move/thing1.png){:.post-thumb}
   ![Extruder filler cover](images/ender6-extruder-move/thing2.png){:.post-thumb}
   ![Extruder filament guide](images/ender6-extruder-move/thing3.png){:.post-thumb}
   1. [Extruder motor spacer mount](https://www.thingiverse.com/thing:4750925/files)
   2. [Extruder filler cover](https://www.thingiverse.com/thing:4771539)
   3. [Extruder filament guide](https://www.thingiverse.com/thing:5031418)

##### 2. Remove the extruder

![Extruder](images/ender6-extruder-move/extruder.png)  
To start, you need to remove the extruder from its existing location on the side of the printer.  

![Extruder removed](images/ender6-extruder-move/IMG_4095.jpeg)  
Unplug the cable and, of course, remove any filament that is threaded through it. Then just unscrew the extruder in the reverse of how you installed it when you first built the printer. Keep the screws.

##### 3. Add the spacer

![Extruder spacer](images/ender6-extruder-move/IMG_4088.jpeg)  
Take the spacer block you printed out and attach it to the extruder mounting plate using some M4 screws and T-nuts. _(Note in the picture I printed my own t-nuts before my order arrived from Amazon)_

##### 4. Re-mount the extruder

![Extruder mounted](images/ender6-extruder-move/IMG_4091.jpeg)
![Extruder mounted](images/ender6-extruder-move/IMG_4094.jpeg)  
Now attach the extruder motor to the top frame bar at the back to the right of the z-axis mount. **Don't lose the spacer you just added**. It may be a tight fit between the z-axis bar and the cable holder. 

**IMPORTANT: Test the fit by moving the bed up manually and making sure it doesn't hit the extruder motor. If it does, you may need to move both the extruder and cable holder over to the right a little. _Test this, don't skip it!_**
{:.alert-danger}

##### 5. Bowden Tube

You will need to shorten the Bowden tube as much as you can to get the most benefit from this move.  Before you trim it, move the print head to the furthest point from the extruder and measure the shortest length you think you can get away with.  Remember you can always trim more later, but you can't add any back.

##### 6. Add filament guide and filler plate

![Filament guide](images/ender6-extruder-move/IMG_4008.jpeg)  
Attach the filament guide to the top of the frame using the other two M4 screws and nuts

![Filler plate](images/ender6-extruder-move/IMG_4086.jpeg)  
Lastly, push the filler plate into the hole where the extruder used to be.

Now you should be all set to thread the filament through the guide and into the extruder.  You should find that you can reduce the extraction distance in your slicer settings with good results.

![Success](images/ender6-extruder-move/IMG_3470.jpeg)
![Success](images/ender6-extruder-move/IMG_3472.jpeg)

Success!

##### [Please leave comments here. I am always open to improving these posts](https://www.reddit.com/r/MarksMakerSpace/comments/qhgpg7/ender_6_reduce_stringing_by_moving_the_extruder/)