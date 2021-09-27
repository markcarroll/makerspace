---
layout: post
title: Ender 6 Specs
date: 2021-09-26 08:21
category: 3dprinting
author: Mark
image: /3dprinting/images/ender6-specs/65f565cf-3daa-400a-805b-56b6722f66a2.jpeg
tags: [3dprinting, ender6]
summary: Compilation of specs for Ender 6
---

This is a compilation of the Ender 6 specifications that I have been able to find for my reference.

## Overall Specs

| Modeling Technology | FDM（Fused Deposition Modeling） |
| Print Size | 250x250x400mm |
| Print Mode | SD card |
| Resolution | ±0.1mm |
| Supported OS | MAC, LINUX, WIN7/8/10 |
| File Formats | STL, 3MF, AMF, OBJ, Gcode |
| Printing Material | PLA/TPU/Wood/Carbon Fiber, etc. |
| Machine Size | 495x495x650mm |
| Product Weight | 22KG |
| Touch Screen | 4.3 inch |
| G.W. | 27kg |

## Stepper Motors

### Extruder

|                     |                         |
| ------------------- | ----------------------- |
| Brand               | Creality 3D             |
| Item name           | RepRap 42 Stepper Motor |
| Item number         | 42-60                   |
| Size                | 42x42x60mm              |
| Step angle          | 1.8 degrees             |
| Nominal Voltage     | 4.83V                   |
| Current Rating      | 1.5 (A)                 |
| Rated speed         | 1-1000 (rpm)            |
| Rated torque        | 0.4 (NM)                |
| Ambient Temperatuar | -20℃~+50℃               |
| Length              | 60mm                    |

{% include image-gallery.html folder="images/ender6-specs/extruder" showFilename=false %}

### X & Y Axis Motors

|                     |                         |
| ------------------- | ----------------------- |
| Brand               | Creality 3D             |
| Item name           | RepRap 42 Stepper Motor |
| Item number         | 42-48                   |
| Size                | 42x42x48mm              |
| Step angle          | 1.8 degrees             |
| Nominal Voltage     |                         |
| Current Rating      |                         |
| Rated speed         |                         |
| Rated torque        |                         |
| Ambient Temperatuar | -20℃~+50℃               |
| Length              | 48mm                    |

{% include image-gallery.html folder="images/ender6-specs/xymotors" showFilename=false %}

<iframe style="width:120px;height:240px;float:right" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=mwp-14-20&language=en_US&marketplace=amazon&region=US&placement=B0933LWH7R&asins=B0933LWH7R&linkId=fafee0fad658d0f0096242ad6c080b56&show_border=true&link_opens_in_new_window=true"></iframe>

### Trinamic Stepper Motor Drivers

I am running my Ender 6 on a [BigTreeTech SKR 2](https://amzn.to/3lZWB4q) main board with [Trinamic TMC2209 drivers](https://amzn.to/3EVruPR) as my machine was a victim of Creality's **_board fraud_** and contained two A4988 drivers for the Z and extruder steppers instead of the advertised TMC2208's. So I decided to go one better and installed an SKR 2 with five TMC2209s. Why five you may ask, well I am planning on eventually adding a second extruder for two color printing.

Long story short, here is the datasheet for the TMC2209 drivers: [_TMC2209 datasheet_](files/ender6-specs/TMC2209_Datasheet_V103.pdf)

I will add more specs as I come across them.

#### [Post Comments here](https://www.reddit.com/r/MarksMakerSpace/comments/pwagl1/ender_6_specs_and_datasheets/)
