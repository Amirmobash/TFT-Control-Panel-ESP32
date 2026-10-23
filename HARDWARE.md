# Hardware and electrical integration / Hardware und Anschluss

This is a hardware reference based on GPIO constants shared across the inspected firmware files. **It is not a verified wiring schematic.** / Die Angaben stammen aus den GPIO-Definitionen des Quellcodes; sie ersetzen keinen geprüften Schaltplan.

| Module / Modul | Pin | ESP32 | Caution / Hinweis |
|---|---|---|---|
| ILI9341 TFT | SCK | 18 | SPI clock |
| ILI9341 TFT | MOSI | 23 | SPI MOSI |
| ILI9341 TFT | MISO | 19 | SPI MISO where present |
| ILI9341 TFT | CS | 15 | Check ESP32 boot strapping |
| ILI9341 TFT | DC | 2 | Check ESP32 boot strapping |
| ILI9341 TFT | RST | 4 | Check ESP32 boot strapping |
| Analog joystick | X | 35 | ADC input |
| Analog joystick | Y | 34 | ADC input |
| Joystick switch | SW | 27 | Input; source uses pull-up logic |
| Pressure transducer | Signal | 33 | **Never connect industrial 5 V / 10 V / 24 V sensor output directly** |
| Relay module driver | Control | 25 | Active-LOW in inspected sketches |
| External trigger | Input | 32 | Input; check sensor output level and polarity |

## Before powering the prototype

- Verify voltage and current requirements for **your actual TFT board** (bare logic and breakout boards are not necessarily identical).
- Provide a common ground wherever required by the selected modules.
- Keep every ESP32 GPIO within its specified voltage range; use a proper divider, buffer or interface for a higher-voltage sensor.
- Confirm the relay board's trigger polarity and inactive state during boot. Some ESP32 pins change behavior while booting.
- Test low-voltage signals first with the load disconnected. Use professionally rated isolation for mains or high-energy equipment.
- Confirm the pressure sensor transfer curve, reference unit, acceptable operating range and mechanical limits before calibration.

## Firmware assumptions

The full sketches instantiate `Adafruit_ILI9341`, initialize SPI and use GPIO 33 as an ADC pressure input. Variants with two-point calibration store coefficients in `Preferences`. Never transfer calibration parameters blindly across different sensors or firmware versions.
