# ESP32 TFT Control Panel — Pressure Monitoring & Relay Control

**An ESP32-based control interface with a 240 × 320 ILI9341 TFT, joystick navigation, pressure-sensor calibration, configurable relay timing and a local Wi-Fi dashboard.**

[Deutsch](README.de.md) · [Hardware and wiring](HARDWARE.md) · [Safety and network notes](SECURITY.md) · [Source repository](https://github.com/Amirmobash/TFT-Control-Panel-ESP32)

## About the project

This project grew out of a practical need for a compact, standalone control panel. The ESP32 handles a small TFT interface, a joystick, pressure monitoring and a relay output. Selected firmware variants also expose settings through a web interface hosted on the ESP32 itself. The on-device interface is labelled **W-GLÄTTER** / **Kabelglaetter** in the source.

The repository currently contains several experimental or evolutionary firmware files. **They are alternatives, not components to compile together.** No single version is documented as a verified release; the hardware must be checked against the sketch selected for flashing.

## What the code implements

- 240 × 320 ILI9341 TFT menu using Adafruit GFX and SPI
- Analog joystick navigation with a push button
- Sensor-triggered, joystick-triggered and timed automatic relay operation
- Analog pressure reading and status indication
- Pressure zero calibration; scale/span calibration in newer variants
- Stored settings using ESP32 `Preferences` (NVS)
- ESP32 Wi-Fi access-point mode and local HTTP configuration UI in the full firmware variants

These are **source-code features**, not a claim of completed field testing, calibrated accuracy or product certification.

## Hardware overview

The inspected firmware variants share the pin definitions below. Check the actual module pinout and voltage compatibility before supplying power.

| Function | ESP32 GPIO | Interface |
|---|---:|---|
| TFT clock / MOSI / MISO | 18 / 23 / 19 | SPI |
| TFT chip select / D-C / reset | 15 / 2 / 4 | Digital |
| Joystick X / Y | 35 / 34 | ADC input |
| Joystick button | 27 | Digital input |
| Analog pressure input | 33 | ADC input |
| Relay control | 25 | Digital output; active LOW in inspected variants |
| External sensor trigger | 32 | Digital input |

**Important:** GPIO 33 is an analog measurement input, not a direct connection for arbitrary industrial pressure-sensor supply voltages. The input must stay within the ESP32 electrical limits. Relay contacts must not be connected directly to the ESP32 pin; use a properly rated driver or relay module.

For details, see [HARDWARE.md](HARDWARE.md).

## Firmware variants

| Original file | Notes |
|---|---|
| `glatter sensor.ino` | Earlier web-enabled control panel with pressure zero calibration |
| `sketch_oct28a.ino` | Another earlier firmware snapshot with web settings |
| `complete presur.cpp` | Adds zero and span calibration work |
| `Pressure Sensor Calibration Code.cpp` | Extended pressure calibration and web UI |
| `glatterc28a.ino` | Extended sketch containing zero and scale calibration |
| `Amirmobasher-n8n` | Separate repository file; not presented as flashable ESP32 firmware |

These descriptions are based on the checked source. A `.cpp` file may require adapting into an Arduino sketch or integrating into an Arduino build; it is not automatically flashable on its own.

## Getting started

1. Install Arduino IDE 2.x and the Espressif ESP32 board package.
2. Install **Adafruit GFX Library** and **Adafruit ILI9341** through Library Manager. `SPI`, `WiFi`, `WebServer` and `Preferences` are supplied by the ESP32 environment used by these sketches.
3. Choose **one** `.ino` firmware variant and place it inside an Arduino sketch folder with a matching filename, for example `glatterc28a/glatterc28a.ino`.
4. Verify the TFT type, power supply, pressure transducer, joystick and relay-driver wiring against [HARDWARE.md](HARDWARE.md).
5. Before flashing, **replace the example access-point password embedded in the firmware**, and inspect any HTTP control or configuration endpoints. See [SECURITY.md](SECURITY.md).
6. Select the board and serial port, build and upload. First test with the relay load disconnected.
7. Check menu navigation, sensor readings, relay polarity and automatic shutdown before connecting a real actuator.

### Using the local web interface

The inspected full sketches configure an ESP32 access point named `Kabelglaetter` and a server on port 80. The configured address is `192.168.4.1` in the inspected variants. Connect only in a trusted environment after replacing the default credentials. Some settings and calibration functions differ across firmware variants.

## Pressure calibration

The firmware uses an analog voltage and configurable conversion factors to compute a displayed pressure value. Hardware calibration is essential:

1. Confirm the sensor's voltage transfer function and safe interface to GPIO 33.
2. With a known zero-pressure condition, perform zero calibration.
3. For a firmware variant supporting scale/span calibration, apply a measured reference pressure within the sensor's rated range.
4. Check at additional reference points. A two-point calibration does **not** establish accuracy or linearity across the entire range.

Never rely on this code as a certified pressure protection or safety interlock.

## Project status and limitations

This is a hobbyist/prototype-level source repository. There is no committed test harness, CI workflow, tagged stable release or explicit source license visible in the inspected repository snapshot. Existing firmware files use partly different calibration flows and naming conventions. Do not combine them into a single Arduino build without deliberate refactoring.

## Repository description and discovery

Suggested GitHub description:

> ESP32 ILI9341 TFT control panel with joystick menu, pressure sensor calibration, relay automation and local Wi-Fi dashboard.

Suggested GitHub topics (set them in the repository About panel): `esp32`, `ili9341`, `tft-display`, `arduino`, `pressure-sensor`, `relay-control`, `joystick`, `embedded-systems`, `wifi-dashboard`, `sensor-calibration`.

Clear descriptions, a working example and accurate screenshots help discoverability more than keyword repetition. Search ranking is not guaranteed.

## Author and contributions

Developed by [Amirmobash](https://github.com/Amirmobash). Bug reports and reproducible hardware notes are welcome. When reporting an issue, include the exact firmware filename, ESP32 board, display module, sensor model and serial output **with network credentials removed**.

## License

**No license file was present in the inspected repository.** Until the owner explicitly chooses and publishes a license, do not assume the source is under MIT, GPL or another open-source license. Existing source notices may impose additional restrictions.
