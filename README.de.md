# ESP32 TFT-Steuerpanel — Drucküberwachung und Relaissteuerung

**ESP32-Steuerung mit ILI9341-TFT (240 × 320 Pixel), Joystick-Menü, Drucksensor-Kalibrierung, zeitgesteuertem Relais und lokalem WLAN-Dashboard.**

[English README](README.md) · [Hardware / Pinbelegung](HARDWARE.md) · [Sicherheit](SECURITY.md) · [GitHub-Projekt](https://github.com/Amirmobash/TFT-Control-Panel-ESP32)

## Projektübersicht

Das Projekt ist als kompakte Bedien- und Steuerlösung für eigene Elektronikaufbauten entstanden. Ein ESP32 übernimmt die Darstellung auf dem TFT, die Joystick-Bedienung, die Auswertung eines analogen Drucksignals und die Ansteuerung eines Relais. Umfangreichere Firmware-Varianten bieten zusätzlich eine lokale Weboberfläche für Einstellungen. Die Bezeichnungen **W-GLÄTTER** und **Kabelglaetter** stammen aus dem Quellcode.

Im Repository liegen mehrere Entwicklungsstände. **Die Dateien sind alternative Firmware-Versionen und dürfen nicht einfach zusammen kompiliert werden.** Ein offiziell geprüfter, stabiler Release ist in der untersuchten Repository-Version nicht ausgewiesen.

## Funktionen im Quellcode

- SPI-TFT mit ILI9341 und Adafruit GFX, Auflösung 240 × 320
- Joystick-Navigation einschließlich Drucktaster
- Sensormodus, Joystick-Modus und Automatikmodus zur Relaissteuerung
- Analoge Druckmessung und Statusanzeige
- Nullpunktkalibrierung; bei neueren Varianten auch Skalierungs-/Zweipunktkalibrierung
- Speicherung von Parametern über ESP32 Preferences (NVS)
- WLAN-Access-Point und lokale HTTP-Bedienoberfläche bei umfangreichen Varianten

Dies sind Eigenschaften des Codes, **keine Bestätigung einer geprüften Messgenauigkeit oder elektrischen Sicherheit**.

## Pinbelegung

| Funktion | ESP32-GPIO |
|---|---:|
| TFT SCK / MOSI / MISO | 18 / 23 / 19 |
| TFT CS / DC / Reset | 15 / 2 / 4 |
| Joystick X / Y | 35 / 34 |
| Joystick-Taster | 27 |
| Drucksensor (analoger Eingang) | 33 |
| Relais-Steuersignal (Active LOW) | 25 |
| Externer Sensoreingang | 32 |

Die Spannung am ESP32-Eingang darf die zulässigen Grenzwerte nicht überschreiten. Ein Relais beziehungsweise eine Last darf nur über eine dafür ausgelegte Treiberschaltung angeschlossen werden. Weitere Hinweise: [HARDWARE.md](HARDWARE.md).

## Firmware-Dateien

| Datei | Einordnung |
|---|---|
| `glatter sensor.ino` | Frühere Version mit Weboberfläche und Nullpunktkalibrierung |
| `sketch_oct28a.ino` | Weitere frühe Firmware-Version |
| `complete presur.cpp` | Entwicklung mit Nullpunkt- und Spankalibrierung |
| `Pressure Sensor Calibration Code.cpp` | Erweiterte Druckkalibrierung und Weboberfläche |
| `glatterc28a.ino` | Erweiterte Variante mit Nullpunkt- und Skalierungskalibrierung |
| `Amirmobasher-n8n` | Zusätzliche Datei, kein direkt als Firmware identifizierter Arduino-Sketch |

## Installation und Inbetriebnahme

1. Arduino IDE 2.x und das Espressif-ESP32-Boardpaket installieren.
2. Über den Bibliotheksmanager **Adafruit GFX Library** und **Adafruit ILI9341** installieren.
3. **Eine** `.ino`-Datei auswählen und in einem Sketch-Ordner gleichen Namens öffnen, z. B. `glatterc28a/glatterc28a.ino`.
4. Pinbelegung, Versorgung, Drucksensor und Relais-Treiberschaltung prüfen.
5. Vor dem Flashen das im Quellcode hinterlegte WLAN-Standardpasswort ersetzen; Hinweise in [SECURITY.md](SECURITY.md) beachten.
6. ESP32-Board und Port auswählen, kompilieren und hochladen.
7. Zunächst ohne angeschlossene Last testen: Menü, Kalibrierung, Relais-Logik und Abschaltverhalten kontrollieren.

Die geprüften umfangreichen Versionen richten einen Access Point namens `Kabelglaetter` ein. Der lokale Webserver verwendet Port 80; im Code ist `192.168.4.1` konfiguriert. Bedienfunktionen unterscheiden sich je nach Firmware-Version.

## Drucksensor kalibrieren

Die Umrechnung von Eingangsspannung in Druck hängt vom tatsächlich verwendeten Sensor und der Schaltung ab. Zunächst muss der Sensor bei einem definierten Nullpunkt abgeglichen werden. Unterstützt die ausgewählte Variante die Skalenkalibrierung, kann anschließend ein bekannter Referenzdruck eingestellt werden. Danach sind weitere Prüfpunkte erforderlich. Der Aufbau ersetzt **keine** geprüfte Schutzeinrichtung.

## Projektstatus

Das Repository enthält mehrere Firmware-Stände, jedoch in der geprüften Version keine sichtbaren automatisierten Tests, kein stabiles Release-Tag und keine veröffentlichte Lizenzdatei. Änderungen sollten deshalb zuerst auf einem unbelasteten Testaufbau geprüft werden.

## GitHub-Beschreibung und Schlagwörter

**Kurzbeschreibung für GitHub:**

> ESP32-Steuerpanel mit ILI9341-TFT, Joystick-Menü, Drucksensor-Kalibrierung, Relais-Automatik und lokalem WLAN-Dashboard.

**Themen:** `esp32`, `ili9341`, `tft-display`, `arduino`, `pressure-sensor`, `relay-control`, `joystick`, `embedded-systems`, `wifi-dashboard`, `sensor-calibration`.

## Autor und Lizenz

Projekt von [Amirmobash](https://github.com/Amirmobash). Rückmeldungen mit genauer Firmware-Version, Schaltung und reproduzierbaren Schritten sind willkommen.

**Lizenzhinweis:** Im geprüften Repository war keine Lizenzdatei vorhanden. Daher wird hier keine Open-Source-Lizenz behauptet. Hinweise im bestehenden Quellcode sind zu beachten.
