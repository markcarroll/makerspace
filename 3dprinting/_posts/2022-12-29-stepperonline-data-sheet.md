---
layout: post
title:  "OMC/StepperOnline Stepper Motor Kit Data Sheets"
author: mark
categories: [ 3dprinting ]
tags: [Tronxy X5SA, Ender 6, STL, Models, Prints]
image: /3dprinting/images/stepperonline-data-sheet/VORON-Afterburner-3D-Printer-Nema-17-Stepper-Motor-Kit-17HS19-2004S1-17HS08-1004S-550x550.jpg
description: "Data sheets for OMC/StepperOnline VORON 2.4 Nema 17 Stepper Motor Kit 17HS19-2004S1"
print: false
---

## OMC/StepperOnline Nema 17 Stepper Motor Kit 17HS19-2004S1

Sold as "[VORON 2.4 & Afterburner 3D Printer Nema 17 Stepper Motor Kit 17HS19-2004S1](https://www.omc-stepperonline.com/voron-afterburner-3d-printer-nema-17-stepper-motor-kit-17hs19-2004s1-17hs08-1004s-voron)"

Package includes:

- 1 x Nema 17 Bipolar 1.8deg 16Ncm (22.6oz.in) 1A 3.7V 42x42x20mm 4 Wires 17HS08-1004S
- 6 x Nema 17 Bipolar 59Ncm (84oz.in) 2A 42x48mm 4 Wires w/ 1m Cable & Connector 17HS19-2004S1

Since most people are probably upgrading to StealthBurner and CW2 the single 17HS08-1004S is not needed for that mod.

I bought these from West3D for $89.99+Tax, however I have since found that OMC/StepperOnline is selling them [direct on Amazon](https://amzn.to/3YUHBqZ) for a lot cheaper.

### Electrical Specification

|Manufacturer Part Number| 17HS19-2004S1|
|Motor Type| Bipolar Stepper|
|Step Angle| 1.8 deg|
|Holding Torque| 59Ncm(84oz.in)|
|Rated Current/phase| 2.0A|
|Phase Resistance| 1.4ohms|
|Inductance| 3.0mH ± 20%(1KHz)|

### Physical Specification

|Frame Size| 42 x 42mm|
|Body Length| 47mm|
|Shaft Diameter| Φ5mm|
|Shaft Length| 24mm|
|D-cut Length| 15mm|
|Number of Leads| 4|
|Lead Length| 1000mm|
|Weight| 390g|

### Connection

|A+|A-|B+|B-|
|Black|Green|Red|Blue|

### Resources

- Full DataSheet: [17HS19-2004S1.pdf](https://www.omc-stepperonline.com/download/17HS19-2004S1.pdf)
- Torque Curve: [17HS19-2004S1 Torque Curve.pdf](https://www.omc-stepperonline.com/download/17HS19-2004S1_Torque_Curve.pdf)

## Klipper settings

According to the formula the 17HS19-2004S1 is specified with a maximum current of 2.0 Amps. Maximum run current is 2.0 \* .707 = 1.414, rounded down to a maximum RMS run current of 1.4 Amps. Maximum hold current is 1.414 \* 0.6 = 0.8484, rounded to a maximum hold current of 0.8 Amps.

However, that produced some very noisy motors for me, so I am currently running them as follows:

```ini
[tmc2209 stepper_x]
uart_pin: PC4
interpolate: false
run_current: 1.1
sense_resistor: 0.110
stealthchop_threshold: 0

[tmc2209 stepper_y]
uart_pin: PD11
interpolate: false
run_current: 1.1
sense_resistor: 0.110
stealthchop_threshold: 0

## this applies to stepper_z to stepper_z3
[tmc2209 stepper_z]
uart_pin: PC6
interpolate: false
run_current: 0.8
sense_resistor: 0.110
stealthchop_threshold: 9999

```