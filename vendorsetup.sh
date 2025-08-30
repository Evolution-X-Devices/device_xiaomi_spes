#!/bin/bash
# Cleanup script to avoid build conflicts
LINEAGE_SEPOLICY_COMMON_VENDOR_DEVICE="device/lineage/sepolicy/common/vendor/device.te"
QTI_KERNEL_HEADER_LINEAGE="vendor/lineage/build/soong/Android.bp"
LEICA_CAMERA_BRANCH="leica-5.0"

# Remove duplicate SELinux declaration
if [ -f "$LINEAGE_SEPOLICY_COMMON_VENDOR_DEVICE" ]; then
    echo "Deleting $LINEAGE_SEPOLICY_COMMON_VENDOR_DEVICE to avoid build conflict..."
    rm -f "$LINEAGE_SEPOLICY_COMMON_VENDOR_DEVICE"
fi

# Remove duplicate qti_kernel_headers block from Android.bp
if [ -f "$QTI_KERNEL_HEADER_LINEAGE" ]; then
    echo "Cleaning lines 97–101 from $QTI_KERNEL_HEADER_LINEAGE to avoid build conflict..."
    sed -i '97,101d' "$QTI_KERNEL_HEADER_LINEAGE"
fi

if check_dir vendor/xiaomi/miuicamera; then
    echo -e "Cloning Leica Camera vendor sources from ItzDFPlayer (branch: $LEICA_CAMERA_BRANCH)"
    git clone https://gitlab.com/ItzDFPlayer/vendor_xiaomi_miuicamera -b $LEICA_CAMERA_BRANCH vendor/xiaomi/miuicamera
fi