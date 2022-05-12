#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from spes/spesn device
$(call inherit-product, device/xiaomi/spes/device.mk)

# Inherit some common PixelStar stuff.
$(call inherit-product, vendor/pixelstar/config/common_full_phone.mk)

# Product Specifics
PRODUCT_NAME := PixelStar_spes
PRODUCT_DEVICE := spes
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi Note 11
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Boot Animaton
TARGET_BOOT_ANIMATION_RES := 1080

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay-lineage

# Fingerprint
BuildFingerprint="Redmi/spes/spes:13/TKQ1.221114.001/V14.0.6.0.TGKMIXM:user/release-keys"
