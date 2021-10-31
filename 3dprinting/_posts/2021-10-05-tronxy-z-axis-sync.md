---
layout: post
title: Tronxy X5SA Pro Z Axis Sync
date: 2021-10-05 10:10
category: 3dprinting
author: mark
tags: [Tronxy X5SA]
description: Automatically sync Z axis screws before a print on the Tronxy X5SA (Pro)
image: /3dprinting/images/tronxy-z-axis-sync/IMG_3560.jpeg
---

As with a number of 3D printers, the Tronxy X5SA has two Z-axis stepper motors. While normally these help to keep the build plate level, they can get out of alignment when the motors are turned off and, thus, render a previoulsy perfectly level plate wonky.

Marlin has a method of auto-aligning these Z stepper motors using the [`G34` command](https://marlinfw.org/docs/gcode/G034.html). This works well if you have a bed probe and a build of Marlin that supports the `G34` command.

The Tronxy X5SA main board, however, does not support this command so we need to do something else. A user on Thingiverse came up with these great spacer blocks to print and put on your z axis plates. You then move the extruder nozzle out of the way and raise the bed a little bit past zero, enough for the spacer blocks to hit the top frame. You will hear a little grinding noise as each stepper hits the top and starts to lose steps until the other stepper is also at the same level. This effectively lines up the two z axis stepper motors perfectly.

The Thingiverse print is here: <https://www.thingiverse.com/thing:4297432>

Once printed, the following GCode needs to be added to your starting GCode in your slicer (or in Octoprint):

```text
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
M211 S1
G0 X0 Y0 F3500
G28
; End of Calibrated Home
```

My personal preference is to add this in with a `G29` (auto bed level) *while the bed is heating up*, so it is taking advantage of otherwise dead time.  So my start gcode would now look like:

```text
; start heating up the bed while we do z-axis sync 
M107 T0
M140 S{material_bed_temperature_layer_0}

; move up just to be safe
G91
G0 F480 Z20
G90

; now start the calibration
G28                 ; first Home
G0 Z10              ; move the print head up 
G0 F3500 X330 Y0    ; move to a place where the nozzle safely move below the bed
M211 S0             ; Disable software endstops
G0 F480 Z-3         ; Z calibration step - move up high enough to 'hit' the top
G0 Z20              ; move Z back to a normal position
M211 S1             ; Enable software endstops

; z axis is now calibrated so lets start heatig the hot end while we bed level
M104 S{material_print_temperature_layer_0} T0

@BEDLEVELVISUALIZER	; tell the Octoprint plugin to watch for reported mesh
G29 T	              ; run bilinear bed probe
G28                 ; second home
; End of calibration

; now wait for the heaters to reach final temp
M190 S{material_bed_temperature_layer_0}
M109 S{material_print_temperature_layer_0} T0

G92 E0 ;Reset Extruder

; perform wipe - this may be different for your printer
G1 Z2.0 F3000 ;Move Z Axis up
G1 X59.6 Y40 Z0.28 F5000.0 ;Move to start position
G1 X59.6 Y260.0 Z0.28 F1500.0 E15 ;Draw the first line
G1 X60 Y260.0 Z0.28 F5000.0 ;Move to side a little
G1 X60 Y40 Z0.28 F1500.0 E30 ;Draw the second line
G92 E0 ;Reset Extruder
G1 Z2.0 F3000 ;Move Z Axis up
```

Now whenever you start a print, your z axis stepper motors will align themselves with a slight noise before starting the print. Very useful and so simple to implement.

#### [Post Comments here](https://www.reddit.com/r/MarksMakerSpace/comments/q7l4sy/tronxy_x5sa_pro_zaxis_sync/)
