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

{% include image-gallery.html folder="images/ender6-extruder-move" %}

The Ender 6 is a great printer in many aspects, but one thing it has always been troubled with is stringing. The original location of the Ender 6 extruder motor is half way down the right hand of the frame. This design means a very long Bowden tube that results in terrible stringing and the need for fairly extreme retractions that still leave a less than perfect print.

### Solution: Move the Extruder


<iframe style="width:120px;height:240px;float:right" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=thingiver-20&language=en_US&marketplace=amazon&region=US&placement=B071KBVZVV&asins=B071KBVZVV&linkId=a20c23557495cea2216fffab003f220c&show_border=true&link_opens_in_new_window=true"></iframe>
<iframe style="width:120px;height:240px;float:right" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=thingiver-20&language=en_US&marketplace=amazon&region=US&placement=B07Z4YH6NP&asins=B07Z4YH6NP&linkId=eace030bcd57d72a0d243857f979b755&show_border=true&link_opens_in_new_window=true"></iframe>

#### Parts List

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

- [M2,3,4 Screw Set - _Amazon_](https://amzn.to/2ZqHitO)
- [T Slot Nut Set - _Amazon_](https://amzn.to/3pLfqfc)

#### Instructions

The way to reduce stringing is to shorten the Bowden tube.  Pushing and pulling a flexible filament through a flexile tube is never going to be as exact as we would like.  So shorterning the tube should lessen the negative effects.  The best way to do that without buying any new parts is to move the extuder closer to the hot end.  

As it happens the Ender 6 design has a perfect spot for the extruder that seems like it was almost made for this change.

1. First before you disassemble the printer you will need to print these three items:
   1. [Extruder motor spacer mount](https://www.thingiverse.com/thing:4750925/files)
   2. [Extruder filler cover](https://www.thingiverse.com/thing:4771539)
   3. [Extruder filament guide](https://www.thingiverse.com/thing:5031418)
2. First you need to remove the extruder from its exisiting location on the side of the printer.  Unplug the cable and, of course, remove any filament that is threaded through it.
3. Next, the black tube with the cables running through it from the hot end to the frame needs to be detached from the frame.  Don't move it far though, we are going to re-attach it close to where we took it off soon.
4. Now attach the extruder motor to the top frame bar at the back to the right of the z-axis mount. **Don't forget to add the spacer you printed earlier in #1**. For this you will a pair of M4 screws and M4 T-nuts.
5. Use one of the screw hole in the frame from where you removed the cable tube to re-attach the cable holder. Use the other M4 screw for the other hole.  
6. Now you will need to shorten the Bowden tube as much as you can.  Before you trim it, move the print head to the furthest point from the extruder and measure the shortest length you think you can get away with.  Remember you can always trim more later, but you can't add any back.
7. Attach the filament guide to the top of the frame using the other two M4 screws and nuts
8. Lastly, push the filler plate into the hole where the extruder used to be.

Now you should be all set to thread the filament through the guide and into the extruder.  You should find that you can reduce the extraction distance in your slicer settings and still get good results. 


#### [Post Comments here](https://www.reddit.com/r/MarksMakerSpace/comments/q7l4sy/tronxy_x5sa_pro_zaxis_sync/)