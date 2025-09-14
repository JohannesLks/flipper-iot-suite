# Flipper IoT Suite

![](./data/logo.png)

IoT Discovery & Attack Simulation Toolkit for Flipper Zero

The Flipper IoT Suite is an out-of-tree application (`.fap`) for Flipper Zero.  
It allows security researchers and pentesters to discover, analyze, and interact with common smart home and IoT devices using the Flipper's built-in radios and optional extensions.

---

## Features (Planned)

- Discovery
  - BLE device scanning (addresses, RSSI, services, manufacturer data)
  - Sub-GHz probe (433/868 MHz signal detection & fingerprinting)
  - Optional Zigbee discovery via USB dongle (RF52840)
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
- ESP32 DevKit for Wi-Fi sensor mode
- RF52840 USB dongles
- NRF52840 DK


### Build Instructions

Clone the repo:

```bash
git clone https://github.com/johanneslks/flipper-iot-suite.git
cd flipper-iot-suite
```

Build the FAP file:

```bash
./build.sh
```

The build script will:
1. Clone the Flipper Zero firmware repository
2. Set up the ARM cross-compilation toolchain
3. Compile the IoT Suite application
4. Generate `iot_suite.fap` file

**Installation:**
1. Copy `iot_suite.fap` to your Flipper Zero SD card under `/ext/apps/Tools/`
2. Launch the app from the Flipper Zero menu

**Requirements:**
- Docker (for cross-compilation)
- Git (for firmware repository)
- Flipper Zero with SD card

# resources

https://cujo.com/blog/thread-support-for-flipper-zero-part-2-setup/
https://cujo.com/blog/thread-support-for-flipper-zero-part-3-interfacing-thread-networks-and-data-sets/