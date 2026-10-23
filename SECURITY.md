# Security and safe deployment / Sicherheit

## Network configuration

The inspected firmware contains a **hard-coded default Wi-Fi access-point password** and exposes a local `WebServer` on port 80. Change the AP password before deploying or sharing a device. Review the HTTP endpoints and make sure only trusted clients can connect. A Wi-Fi password is not equivalent to application-level authentication, and plain HTTP is not encrypted.

**Do not expose this prototype's web interface to the public Internet.** Avoid forwarding its port through your router. Remove credentials and device-specific data from logs, screenshots and issues.

## Actuator and pressure safety

A firmware-controlled relay is not an emergency stop or certified protective device. Unexpected reset, GPIO boot states, incorrect active-LOW wiring, watchdog behavior or a code defect can energize an output. Use an independent safety interlock, properly rated relay driver and fail-safe hardware where required.

The analog pressure calculation is specific to the sensor and calibration data. Never use its reading as the sole protection against overpressure. Validate physical wiring and measurement accuracy separately.

## Responsible issue reports

Report the affected firmware filename, steps to reproduce, expected versus observed behavior, ESP32 board and relevant sanitized serial logs. Do not post Wi-Fi credentials or other secrets.

---

## Deutsch

In mehreren Firmware-Dateien sind ein WLAN-Standardpasswort sowie ein unverschlüsselter HTTP-Webserver hinterlegt. **Vor der Nutzung das Passwort ändern**, Schnittstellen prüfen und den Webserver nicht über das öffentliche Internet erreichbar machen. Das WLAN-Passwort ersetzt keine zusätzliche Anmeldung am Webinterface.

Ein softwaregesteuertes Relais ist keine Not-Aus- oder Sicherheitseinrichtung. Externe Schutzeinrichtungen und eine geeignete Treiberstufe sind bei gefährlichen Lasten erforderlich. Eine softwarekalibrierte Druckanzeige ist kein zertifizierter Überdruckschutz.
