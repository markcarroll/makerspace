---
layout: post
title: Tronxy X5SA Pro Z Axis Sync
date: 2021-10-05 10:10
category: 3dprinting
author: Mark
tags: [Tronxy X5SA]
summary: Automatically sync Z axis screws before a print on the Tronxy X5SA (Pro)
image: /3dprinting/images/tronxy_z_axis_sync/IMG_3560.jpeg
---

As with a number of 3D printers, the Tronxy X5SA has two Z-axis stepper motors. While normally these help to keep the build plate level, they can get out of alignment when the motors are turned off and, thus, render a previoulsy perfectly level plate wonky.

Marlin has a method of auto-aligning these Z stepper motors using the [`G34` command](https://marlinfw.org/docs/gcode/G034.html). This works well if you have a bed probe and a build of Marlin that supports the `G34` command.

The Tronxy X5SA main board, however, does not support this command so we need to do something else. A user on Thingiverse came up with these great spacer blocks to print and put on your z axis plates. You then move the extruder nozzle out of the way and raise the bed a little bit past zero, enough for the spacer blocks to hit the top frame. You will hear a little grinding noise as each stepper hits the top and starts to lose steps until the other stepper is also at the same level. This effectively lines up the two z axis stepper motors perfectly.

The Thingiverse print is here: <https://www.thingiverse.com/thing:4297432>

Once printed, the following GCode needs to be added to your starting GCode in your slicer (or in Octoprint):

```
; Home with Z adjust and Z alignment
; move up just to be safe
G91
G0 F480 Z20
G90
; first Home
G28
G0 Z10
; move to a place where the nozzle safely move below the bed
G0 F3500 X330 Y0
; Disable software endstops
M211 S0
; Z calibration step
G0 F480 Z-3
G0 Z20
; Enable software endstops
M211 S0
G0 X0 Y0 F3500
G28
; End of Calibrated Home
```

Now whenever you start a print, your z axis stepper motors will align themselves with a slight noise before starting the print. Very useful and so simple to implement.

#### [Post Comments here](https://www.reddit.com/r/MarksMakerSpace/)
