# Flipper IoT Suite

IoT Discovery & Attack Simulation Toolkit for Flipper Zero

The Flipper IoT Suite is an out-of-tree application (`.fap`) for Flipper Zero.  
It allows security researchers and pentesters to discover, analyze, and interact with common smart home and IoT devices using the Flipper's built-in radios and optional extensions.

---

## Features (Planned)

- Discovery
  - BLE device scanning (addresses, RSSI, services, manufacturer data)
  - Sub-GHz probe (433/868 MHz signal detection & fingerprinting)
  - Optional Zigbee discovery via USB dongle (CC2652/CC2531)
  - Optional Wi-Fi discovery via ESP32 companion sensor

- Analysis
  - Device database with JSONL export
  - Heuristics for common security issues (e.g. unprotected BLE characteristics, static Sub-GHz codes)

- Interaction (Safe Simulation Only)
  - BLE GATT browsing and safe read/write tests
  - Sub-GHz record and replay (non-rolling only, lab use)
  - Context-aware hints (e.g. "device uses Just Works pairing")

- Data Export
  - JSONL logs stored under `/ext/apps_data/iot_suite/`
  - Easy import into Python, Jupyter, or other analysis tools

---

## Disclaimer

This project is for educational and authorized security testing only.  
Do not use it on devices you do not own or have explicit permission to test.  
Illegal or unethical use is strictly discouraged.

---

## Getting Started

### Requirements
- Flipper Zero with latest firmware
- SD card installed
- Docker (recommended) or ARM GCC toolchain
- Optional: CC2652/CC2531 Zigbee USB stick
- Optional: ESP32 DevKit for Wi-Fi sensor mode

### Build Instructions

Clone the repo:

```bash
git clone https://github.com/johanneslks/flipper-iot-suite.git
cd flipper-iot-suite
```