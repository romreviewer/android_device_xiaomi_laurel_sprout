# TWRP Device Tree for Xiaomi Mi A3 (laurel_sprout)

[![TWRP Version](https://img.shields.io/badge/TWRP-3.7.1__14--0-blue)](https://twrp.me/)
[![Android](https://img.shields.io/badge/Android-15-green)](https://www.android.com/)
[![License](https://img.shields.io/badge/License-Apache%202.0-red)](LICENSE)

Unofficial TWRP device tree for Xiaomi Mi A3 with Android 15 support.

---

## Device Specifications

| Feature | Specification |
|---------|---------------|
| **Device** | Xiaomi Mi A3 |
| **Codename** | laurel_sprout |
| **Chipset** | Qualcomm SM6125 Snapdragon 665 (11nm) |
| **CPU** | Octa-core (4x2.0 GHz Kryo 260 Gold & 4x1.8 GHz Kryo 260 Silver) |
| **GPU** | Adreno 610 |
| **RAM** | 4 GB / 6 GB |
| **Storage** | 64 GB / 128 GB |
| **Display** | 6.088" Super AMOLED, 720 x 1560 pixels |
| **Battery** | 4030 mAh, Li-Po |
| **Released** | July 2019 |

---

## TWRP Features

| Feature | Status |
|---------|--------|
| Boots | ✅ Working |
| ADB | ✅ Working |
| ADB Sideload | ✅ Working |
| MTP | ✅ Working |
| Decryption (FBE) | ✅ Working |
| Vibration | ✅ Working |
| Screen Brightness | ✅ Working |
| A/B Slot Switching | ✅ Working |
| Flash Boot/Recovery | ✅ Working |
| Flash System/Vendor | ✅ Working |

---

## Supported Android Versions

| Android Version | ROM | Status |
|-----------------|-----|--------|
| Android 15 | LineageOS 22.2 | ✅ Fully Tested |
| Android 14 | LineageOS 21 | ✅ Should Work |
| Android 13 | Custom ROMs | ✅ Should Work |

---

## Building Instructions

### 1. Set up build environment

```bash
# Install dependencies (Ubuntu/Debian)
sudo apt update
sudo apt install git-core gnupg flex bison build-essential zip curl \
    zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
    libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
```

### 2. Initialize TWRP source

```bash
mkdir twrp && cd twrp
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-14.1
repo sync -j$(nproc)
```

### 3. Clone device tree

```bash
git clone https://github.com/romreviewer/android_device_xiaomi_laurel_sprout.git \
    -b twrp-14.1 device/xiaomi/laurel_sprout
```

### 4. Build recovery

```bash
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch twrp_laurel_sprout-ap2a-eng
mka -j$(nproc) bootimage
```

### 5. Output

Recovery image will be at:
```
out/target/product/laurel_sprout/boot.img
```

---

## Installation

### Prerequisites
- Unlocked bootloader
- ADB & Fastboot installed
- USB drivers installed

### Flash Commands

```bash
# Boot to fastboot mode (Power + Volume Down)

# Flash to both slots (A/B device)
fastboot flash boot_a boot.img
fastboot flash boot_b boot.img

# Reboot to recovery
fastboot reboot recovery
```

### Boot to Recovery
- **From Fastboot:** `fastboot reboot recovery`
- **From System:** `adb reboot recovery`
- **Hardware:** Power off → Hold Power + Volume Up

---

## File Structure

```
device/xiaomi/laurel_sprout/
├── Android.bp
├── Android.mk
├── AndroidProducts.mk
├── BoardConfig.mk
├── README.md
├── bootctrl/
│   └── Android.bp
├── device.mk
├── gpt-utils/
│   ├── Android.bp
│   ├── gpt-utils.cpp
│   └── gpt-utils.h
├── recovery/
│   └── root/
│       ├── init.recovery.qcom.rc
│       ├── init.recovery.usb.rc
│       ├── system/
│       │   ├── bin/           # Crypto binaries
│       │   └── etc/           # Config files
│       └── vendor/
│           ├── etc/           # VINTF manifests
│           └── lib64/         # Crypto libraries
├── twrp.dependencies
├── twrp_laurel_sprout.mk
├── vendor.prop
└── vendorsetup.sh
```

---

## Key Configuration

### BoardConfig.mk Highlights

```makefile
# Platform
TARGET_BOARD_PLATFORM := trinket
TARGET_BOOTLOADER_BOARD_NAME := trinket

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_VARIANT := cortex-a73

# Kernel
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_BOOTIMG_HEADER_VERSION := 2

# Partitions (A/B)
AB_OTA_UPDATER := true
BOARD_USES_RECOVERY_AS_BOOT := true

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
```

---

## Changelog

### v1.0 (2026-04-17)
- Initial release
- Android 15 / LineageOS 22.2 support
- Boot header version 2 compatibility
- FBE decryption with keymaster 4.0
- Extracted crypto binaries from LineageOS 22.2
- Fixed DTB inclusion for proper boot

---

## Credits & Acknowledgments

### Based On
This device tree is based on the original work by the OrangeFox Recovery team.
Full credit goes to the original authors for the foundational device tree structure.

- **Original Device Tree:** [OrangeFox Recovery - laurel_sprout](https://github.com/OrangeFoxRecovery/device_xiaomi_laurel_sprout)

### Modifications for Android 15
This fork includes significant modifications to support Android 15 (LineageOS 22.2):
- Updated boot header version to v2
- Added DTB support for proper boot
- Extracted and integrated crypto binaries from LineageOS 22.2
- Fixed FBE decryption with keymaster 4.0
- Various fixes for Android 14.1 TWRP source compatibility

### Special Thanks
- [**TeamWin**](https://twrp.me/) - TWRP Recovery Project
- [**OrangeFox Team**](https://orangefox.download/) - Original device tree & OrangeFox Recovery
- [**OrangeFox Recovery**](https://github.com/OrangeFoxRecovery) - Original device tree maintainer
- [**LineageOS Team**](https://lineageos.org/) - Crypto binaries for decryption
- [**Xiaomi**](https://www.mi.com/) - Device manufacturer

---

## Support

- **XDA Thread:** [Coming Soon]
- **Telegram:** [Coming Soon]
- **Issues:** [GitHub Issues](https://github.com/romreviewer/android_device_xiaomi_laurel_sprout/issues)

---

## License

```
Copyright (C) 2024 The Android Open Source Project
Copyright (C) 2024 TeamWin Recovery Project

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
